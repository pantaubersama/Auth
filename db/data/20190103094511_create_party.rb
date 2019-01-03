class CreateParty < SeedMigration::Migration
  def up
    # Run Manually
    # rake seed:rollback MIGRATION=20190103094511 
    # rake seed:migrate MIGRATION=20190103094511 

    # data = [
    #   {
    #     name: "PARTAI KEBANGKITAN BANGSA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/1.jpeg')))
    #   },
    #   {
    #     name: "PARTAI GERAKAN INDONESIA RAYA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/2.jpg')))
    #   },
    #   {
    #     name: "PARTAI DEMOKRASI INDONESIA PERJUANGAN",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/3.jpg')))
    #   },
    #   {
    #     name: "PARTAI GOLONGAN KARYA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/4.jpg')))
    #   },
    #   {
    #     name: "PARTAI NASDEM",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/5.jpg')))
    #   },
    #   {
    #     name: "PARTAI GERAKAN PERUBAHAN INDONESIA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/6.jpg')))
    #   },
    #   {
    #     name: "PARTAI BERKARYA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/7.jpg')))
    #   },
    #   {
    #     name: "PARTAI KEADILAN SEJAHTERA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/8.jpg')))
    #   },
    #   {
    #     name: "PERSATUAN INDONESIA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/8.JPG')))
    #   },
    #   {
    #     name: "PARTAI PERSATUAN PEMBANGUNAN",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/10.jpg')))
    #   },
    #   {
    #     name: "PARTAI SOLIDARITAS INDONESIA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/11.jpeg')))
    #   },
    #   {
    #     name: "PARTAI AMANAT NASIONAL",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/12.jpg')))
    #   },
    #   {
    #     name: "PARTAI HATI NURANI RAKYAT",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/13.jpg')))
    #   },
    #   {
    #     name: "PARTAI DEMOKRAT",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/14.jpg')))
    #   },
    #   {
    #     name: "PARTAI ACEH",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/15.jpg')))
    #   },
    #   {
    #     name: "PARTAI SIRA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/16.jpg')))
    #   },
    #   {
    #     name: "PARTAI DAERAH ACEH",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/17.jpg')))
    #   },
    #   {
    #     name: "PARTAI NANGGROE ACEH",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/18.jpg')))
    #   },
    #   {
    #     name: "PARTAI BULAN BINTANG",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/19.jpg')))
    #   },
    #   {
    #     name: "PARTAI KEADILAN DAN PERSATUAN INDONESIA",
    #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/20.jpg')))
    #   },
    # ]

    # PoliticalParty.create(data)
  end

  def down

  end
end
