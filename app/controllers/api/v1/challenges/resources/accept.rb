class API::V1::Challenges::Resources::Accept < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "challenges" do
    desc "Accept challenge" do
      detail "Accept challenge"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :invite_code, type: String, desc: "Your invite code"
    end
    oauth2
    post "/direct/accept" do
      challenge = Wordstadium::Challenge.find_by invite_code: params.invite_code
      error!('Tantangan sudah diterima / tidak ditemukan', 422) if challenge.nil?

      error!('Belum terkoneksi dengan akun twitter.', 422) if challenge.twitter_uid.present? && !current_user.twitter?

      error!('Akun tertantang tidak sama. Cek user (atau twitter) yang digunakan', 422) unless challenge.check! current_user
      error!('Tantangan sudah diterima', 422) if challenge.accepted?

      s = challenge.accept!

      present :status, s.first
      present :wordstadium, s.last
      present :challenge, challenge, with: API::V1::Challenges::Entities::Challenge
    end
  end

end