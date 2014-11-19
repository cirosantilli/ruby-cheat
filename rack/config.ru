app = Proc.new do |env|
  [
    200,
    {
      'Content-Type' => 'text/plain'
    },
    [Time.now.to_s + "\n"]
  ]
end

class Middleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @body = @app.call(env)
    [@status, @headers, @body << 'Middleware']
  end
end

use(Middleware)

run(app)
