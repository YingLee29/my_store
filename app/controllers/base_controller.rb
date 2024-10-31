# frozen_string_literal: true

class BaseController < ApplicationController
  def index; end

  def upload_file
    file = params[:file]
    if file.present? && File.extname(file.original_filename) == ".xlsx"
      spreadsheet = Roo::Excelx.new(file.path)
      header = spreadsheet.row(1)
      invalid_companies = []
      companies = []

      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        errors = validate_company_data(row)

        if errors.empty?
          begin
            published_at = parse_date(row['publishedAt'])
            created_at = parse_date(row['createdAt'])
            updated_at = parse_date(row['updatedAt'])

            companies << User.new(
              id: row['id'],
              name: row['name'],
              outline: row['outline'],
              country: row['country'],
              ceo: row['ceo'],
              url: row['url'],
              year_of_established: row['yearOfEstablished'].to_i,
              employee: row['employee'].to_i,
              total_funding: row['totalFunding'].to_f,
              customer: row['customer'],
              problem: row['problem'],
              solution: row['solution'],
              competitor: row['competitor'],
              advantage: row['advantage'],
              uvp: row['uvp'],
              channel: row['channel'],
              revenue_stream: row['revenueStream'],
              cost_structure: row['costStructure'],
              growth_potential: row['growthPotential'],
              risk: row['risk'],
              business_partner: row['businessPartner'],
              comment: row['comment'],
              source: row['source'],
              impact: row['impact'],
              vc_comment: row['vcComment'],
              launch_contract_history: row['launchContractHistory'],
              technical_background: row['technicalBackground'],
              unicorn: row['unicorn'],
              centaur: row['centaur'],
              biz_model_img_exist: row['bizModelImgExist'],
              biz_model_img: row['bizModelImg'],
              published_at: published_at,
              slug: row['slug'],
              created_at: created_at,
              updated_at: updated_at,
              published: row['published'],
              user_read: row['userRead'].to_i,
              user_liked: row['userLiked'].to_i,
              tag_ids: row['tagIds'],
              theme_ids: row['themeIds'],
              venture_capital_ids: row['ventureCapitalIds']
            )
          rescue StandardError => e
            Rails.logger.error "Error processing row #{i}: #{e.message}"
            invalid_companies << { row: row, error: e.message }
          end
        else
          Rails.logger.error "Validation errors for row #{i}: #{errors.join(', ')}"
          invalid_companies << { row: row, errors: errors }
        end
      end

      Rails.logger.error "Invalid Companies: #{invalid_companies.inspect}" if invalid_companies.any?

      if invalid_companies.empty?
        # Company.import companies, validate: true
      end
    else
      render json: { error: "No file uploaded or file format is incorrect." }, status: :unprocessable_entity
    end
  end

  private

  def validate_company_data(row)
    errors = []
    errors << "Name can't be blank" if row['name'].blank?
    errors << "Country can't be blank and maximum length is 255" if row['country'].blank? && row['country'].length < 255
    errors << "Ceo can't be blank" if row['ceo'].blank? && row['ceo'].length < 255
    errors << "YearOfEstablished can't be blank" if row['yearOfEstablished'].blank?
    errors << "Employee can't be blank" if row['employee'].blank?
    errors << "Outline can't be blank" if row['outline'].blank?
    errors << "slug can't be blank" if row['slug'].blank?
    errors << "slug can't be blank" if row['slug'].blank?
    errors
  end

  def parse_date(value)
    case value
    when String
      DateTime.parse(value)
    when Date, DateTime
      value
    else
      nil
    end
  rescue ArgumentError
    nil
  end
end
