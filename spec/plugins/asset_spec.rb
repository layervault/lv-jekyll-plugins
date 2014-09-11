describe Jekyll::LayerVault::Asset do
  let (:organization) { "layervault" }
  let (:project) { "project" }
  let (:file) { "folder/file.psd" }
  let (:revision) { 2 }
  let (:asset) { "Group/Asset.png" }
  let (:jekyll_config) { Struct.new(:config) }
  let (:template) { Liquid::Template.parse(source) }
  let (:options) do 
    {
      registers: {
        site: jekyll_config.new({'organization' => organization, 'project' => project})
      }
    }
  end

  ["\"", "'"].each do |q|
    context "without revision number" do
      let (:source) { "{% lv_asset #{q}#{file}#{q} #{q}#{asset}#{q} %}" }
      let (:target) { "https://layervault.com/#{organization}/#{project}/#{file}/assets/#{asset}?raw=1" }

      it "parses successfully" do
        expect {
          template.render nil, options
        }.to_not raise_error
      end

      it "produces a valid URL" do
        expect(template.render(nil, options)).to eq target
      end
    end

    context "with revision number" do
      let (:source) { "{% lv_asset #{q}#{file}#{q} #{q}#{revision}#{q} #{q}#{asset}#{q} %}" }
      let (:target) { "https://layervault.com/#{organization}/#{project}/#{file}/revisions/#{revision}/assets/#{asset}?raw=1" }

      it "parses successfully" do
        expect {
          template.render nil, options
        }.to_not raise_error
      end

      it "produces a valid URL" do
        expect(template.render(nil, options)).to eq target
      end
    end

    context "with dash revision" do
      let (:source) { "{% lv_asset #{q}#{file}#{q} #{q}-#{q} #{q}#{asset}#{q} %}" }
      let (:target) { "https://layervault.com/#{organization}/#{project}/#{file}/assets/#{asset}?raw=1" }

      it "parses successfully" do
        expect {
          template.render nil, options
        }.to_not raise_error
      end

      it "produces a valid URL" do
        expect(template.render(nil, options)).to eq target
      end
    end
  end
end
