RSpec.configure do |config|
  config.before(:each, :mock_airlines) do
    mocked_airlines = {
      "Latam" => "/mock/latam",
      "Gol"   => "/mock/gol",
      "Azul"  => "/mock/azul"
    }
    allow_any_instance_of(ScriptsController).to receive(:airlines).and_return(mocked_airlines)
  end
  config.before(:each) do
    Notice.delete_all
  end
end