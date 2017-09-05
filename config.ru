require 'rack/livereload'

use Struct.new(:app) {
  def call(env)
    app.call(env).tap do |res|
      # NOTE fix encoding for <meta http-equiv="Content-Type" content="text/html; charset="">
      if res[1]['Content-Type']&.include?('text/html')
        res[1]['Content-Type'] = 'text/html; charset=utf-8'
      end
    end
  end
}
use Rack::LiveReload
use Rack::Static, urls: {"/" => 'index.html'}, root: 'public'
run Rack::Directory.new(File.join(__dir__, 'public'))
