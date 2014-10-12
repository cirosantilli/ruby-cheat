app = Proc.new do |env|
  [
    200,
    {
      'Content-Type' => 'text/plain'
    },
    [Time.now.to_s]
  ]
end

run(app)
