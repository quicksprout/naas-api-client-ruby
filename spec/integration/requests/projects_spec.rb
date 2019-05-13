require 'spec_helper'

RSpec.describe(Naas::Requests::Projects, type: :integration) do
  let(:params) do
    {
      :name        => 'My First Project',
      :description => 'My first description'
    }
  end

  describe ".list" do
    it "returns a 200 status code" do
      expect(described_class.list.status).to eq(200)
    end

    it "returns a collection of data" do
      expect(described_class.list.data_attributes).to be_a(Array)
    end
  end

  describe ".retrieve" do
    before(:all) do
      record_params = {
        :id          => 'test-retrieve',
        :name        => 'My First Project',
        :description => 'My first description'
      }

      described_class.create(record_params)
    end

    it "returns a 200 OK" do
      expect(described_class.retrieve('test-retrieve').status).to eq(200)
    end
  end

  describe ".update" do
    before(:all) do
      record_params = {
        :id          => 'test-retrieve',
        :name        => 'My First Project',
        :description => 'My first description'
      }

      described_class.create(record_params)
    end

    it "permits updating the name" do
      expect(described_class.update('test-retrieve', name: 'New Name').status).to eq(200)
    end

    context "with validations" do
      it "ensures there is a name" do
        params[:name] = nil

        expect(described_class.update('test-retrieve', params).status).to eq(409)
      end

      it "ensures the #id is valid" do
        params[:id] = 'invalid id'

        expect(described_class.update('test-retrieve', params).status).to eq(409)
      end
    end
  end

  describe ".create" do
    context "with validations" do
      it "ensures there is a name" do
        params[:name] = nil

        expect(described_class.create(params).status).to eq(409)
      end

      it "ensures the #id is valid" do
        params[:id] = 'invalid id'

        expect(described_class.create(params).status).to eq(409)
      end
    end

    context "with valid data" do
      it "creates a new record" do
        record = described_class.create(params)

        expect(record.status).to eq(201)
      end
    end
  end
end