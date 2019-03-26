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
      error!('Belum terkoneksi dengan akun twitter.', 422) unless current_user.twitter?

      challenge = Challenge.find_by params.invite_code

      error!('Akun penantang tidak sama. Cek user (atau twitter) yang digunakan', 422) unless challenge.check! current_user

      s = challenge.accept!

      present :status, s
      present :challenge, challenge, with: API::V1::Challenges::Entities::Challenge
    end
  end

end