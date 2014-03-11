run lambda { |env|
  [
    200,
    {
      'Content-Type' => 'text/plain'
    },
    # TODO: why return a StringIO and not String?
    StringIO.new(Time.now.to_s)
  ]
}
