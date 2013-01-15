require File.expand_path('../helper', __FILE__)

class PragmaticlyTest < Service::TestCase
  def setup
    @stubs = Faraday::Adapter::Test::Stubs.new
  end

  def test_push
    @stubs.post "/projects/fake_uid/hooks" do |env|
      assert_equal 'pragmatic.ly', env[:url].host
      assert_equal 'application/json',
        env[:request_headers]['content-type']
      [200, {}, '']
    end

    svc = service :push,
      {'project_uid' => 'fake_uid', 'token' => 'fake_token'}, payload
    svc.receive_push
  end

  def service(*args)
    super Service::Pragmaticly, *args
  end
end
