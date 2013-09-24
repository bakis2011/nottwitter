# Be sure to restart your server when you modify this file.

Borker::Application.config.session_store :active_record_store, {
  :key => '_session_id',
  :path => '/',
  :domain => nil,
  :epxire_after => nil,
}
