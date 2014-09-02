describe Jekyll::LayerVault::Project do
  let (:organization) { "layervault" }
  let (:project) { "project" }
  let (:jekyll_config) { Struct.new(:config) }
  let (:template) { Liquid::Template.parse(source) }
  let (:options) do 
    {
      registers: {
        site: jekyll_config.new({'organization' => organization, 'project' => project})
      }
    }
  end
  let (:source) { "{% lv_project %}" }
  let (:template) { Liquid::Template.parse(source) }
  let (:target) { "https://layervault.com/#{organization}/#{project}" }

  it "parses successfully" do
    expect {
      template.render nil, options
    }.to_not raise_error
  end

  it "produces a valid URL" do
    expect(template.render(nil, options)).to eq target
  end
end
