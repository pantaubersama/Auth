class DefaultBadge < SeedMigration::Migration
  def up
    data = [
      {
        position: 1,
        name: "Pantau Bersama",
        code: "pantaubersama",
        namespace: "badge_pantau_bersama",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/pantau-badge.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/pantau-badge.png')))
      },
      {
        position: 2,
        name: "Kontributor Kontent",
        code: "konten",
        namespace: "badge_relawan",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/v-content-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/v-content-1.png')))
      },
      {
        position: 3,
        name: "Kontributor Design",
        code: "design",
        namespace: "badge_relawan",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/v-design-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/v-design-2.png')))
      },
      {
        position: 4,
        name: "Kontributor Development",
        code: "development",
        namespace: "badge_relawan",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/v-development-3.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/v-development-3.png')))
      },
      {
        position: 5,
        name: "Ambrassador",
        code: "ambrassador",
        namespace: "badge_relawan",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/v-ambassador-4.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/v-ambassador-4.png')))
      },
      {
        position: 6,
        name: "Funding",
        code: "funding",
        namespace: "badge_relawan",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/v-funding-5.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/v-funding-5.png')))
      },
      {
        position: 7,
        name: "QA",
        code: "qa",
        namespace: "badge_relawan",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/v-qa-6.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/v-qa-6.png')))
      },
      {
        position: 8,
        name: "Lengkapi Biodata",
        code: "biodata",
        namespace: "badge_profile",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/completed-profile.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/completed-profile.png')))
      },
      {
        position: 9,
        name: "Lengkapi Biodata Lapor",
        code: "biodata_lapor",
        namespace: "badge_profile",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/completed-profile-lapor.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/completed-profile-lapor.png')))
      },
      {
        position: 10,
        name: "Janji Politik 1",
        code: "janji1",
        namespace: "badge_janji_politik",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/janpol-bronze-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/janpol-bronze-1.png')))
      },
      {
        position: 11,
        name: "Janji Politik 5",
        code: "janji5",
        namespace: "badge_janji_politik",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/janpol-bronze-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/janpol-bronze-2.png')))
      },
      {
        position: 12,
        name: "Janji Politik 15",
        code: "janji15",
        namespace: "badge_janji_politik",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/janpol-silver-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/janpol-silver-1.png')))
      },
      {
        position: 13,
        name: "Janji Politik 25",
        code: "janji25",
        namespace: "badge_janji_politik",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/janpol-silver-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/janpol-silver-2.png')))
      },
      {
        position: 14,
        name: "Tanya 1",
        code: "tanya1",
        namespace: "badge_tanya",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/ask2-bronze-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/ask2-bronze-1.png')))
      },
      {
        position: 15,
        name: "Tanya 10",
        code: "tanya10",
        namespace: "badge_tanya",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/ask2-bronze-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/ask2-bronze-2.png')))
      },
      {
        position: 16,
        name: "Tanya 30",
        code: "tanya30",
        namespace: "badge_tanya",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/ask2-silver-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/ask2-silver-1.png')))
      },
      {
        position: 17,
        name: "Tanya 50",
        code: "tanya50",
        namespace: "badge_tanya",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/ask2-silver-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/ask2-silver-2.png')))
      },
      {
        position: 18,
        name: "Tanya Interaksi 50",
        code: "tanyainteraksi50",
        namespace: "badge_tanya_interaksi",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/ask2-b2-bronze-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/ask2-b2-bronze-1.png')))
      },
      {
        position: 19,
        name: "Tanya Interaksi 200",
        code: "tanya200",
        namespace: "badge_tanya_interaksi",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/ask2-b2-bronze-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/ask2-b2-bronze-2.png')))
      },
      {
        position: 20,
        name: "Tanya Interaksi 500",
        code: "tanya500",
        namespace: "badge_tanya_interaksi",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/ask2-b2-silver-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/ask2-b2-silver-1.png')))
      },
      {
        position: 21,
        name: "Tanya Interaksi 1000",
        code: "tanya1000",
        namespace: "badge_tanya_interaksi",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/ask2-b2-silver-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/ask2-b2-silver-2.png')))
      },
      {
        position: 22,
        name: "Kuis 1",
        code: "kuis",
        namespace: "badge_kuis",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/quiz-bronze-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/quiz-bronze-1.png')))
      },
      {
        position: 23,
        name: "Kuis 3",
        code: "kuis3",
        namespace: "badge_kuis",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/quiz-bronze-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/quiz-bronze-2.png')))
      },
      {
        position: 24,
        name: "Kuis 5",
        code: "kuis5",
        namespace: "badge_kuis",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/quiz-silver-1.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/quiz-silver-1.png')))
      },
      {
        position: 25,
        name: "Kuis 10",
        code: "kuis10",
        namespace: "badge_kuis",
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/colored/quiz-silver-2.png'))),
        image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/badges/grayscale/quiz-silver-2.png')))
      }
    ]
    Badge.create!(data)
    Badge.reindex
  end

  def down

  end
end
