describe Jekyll::LayerVault::Download do
  let (:organization) { "layervault" }
  let (:project) { "project" }
  let (:file) { "folder/file.psd" }
  let (:revision) { 2 }
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
      let (:source) { "{% lv_download #{q}#{file}#{q} %}" }
      let (:target) { "https://layervault.com/#{organization}/#{project}/#{file}?raw=1" }

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
      let (:source) { "{% lv_download #{q}#{file}#{q} #{q}#{revision}#{q} %}" }
      let (:target) { "https://layervault.com/#{organization}/#{project}/#{file}/revisions/#{revision}?raw=1" }

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
      let (:source) { "{% lv_download #{q}#{file}#{q} #{q}-#{q} %}" }
      let (:target) { "https://layervault.com/#{organization}/#{project}/#{file}?raw=1" }

      it "parses successfully" do
        expect {
          template.render nil, options
        }.to_not raise_error
      end

      it "produces a valid URL" do
        expect(template.render(nil, options)).to eq target
      end
    end

    context "with example tag" do
      let (:source) { "{% lv_download_example #{q}#{file}#{q} %}" }
      let (:target) { "{% lv_download #{q}#{file}#{q} %}" }

      it "parses successfully" do
        expect {
          template.render nil, options
        }.to_not raise_error
      end

      it "produces valid content" do
        expect(template.render(nil, options)).to eq target
      end
    end
  end
end
