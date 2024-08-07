# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin 'jquery', to: 'jquery.min.js', preload: true
pin 'jquery_ujs', to: 'jquery_ujs.js', preload: true
# pin "popper", to: "popper.js", preload: true
pin 'bootstrap', to: 'bootstrap.min.js', preload: true
pin '@fortawesome/fontawesome-free', to: 'https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.4.0/js/all.js',
                                     preload: true
pin 'select2', to: 'https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.full.min.js', preload: true
pin '@popperjs/core', to: 'popper.js', preload: true
