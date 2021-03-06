class API::V1::Dashboard::Verifications::Resources::Verifications < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams
  resources 'verifications' do
    before do
      authorize_admin!
    end

    desc "Add note to user verification" do
      headers AUTHORIZATION_HEADERS
      detail "Add note to user verification"
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
      requires :note, type: String, desc: "Note"
    end
    put '/note' do
      u = User.find params.id
      result = u.update_attribute(:note, params.note)
      present result
    end

    desc "Reset user verification" do
      headers AUTHORIZATION_HEADERS
      detail "Reset user verification"
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
      requires :step, type: Integer, desc: "Step", values: [1,2,3,4]
    end
    put '/reset' do
      u = User.find params.id
      ver = u.verification

      error! "You have to add note before resetting verification", 422 if u.note.nil?

      result = ver.reset! params.step
      present true
    end

    desc "show user verification" do
      headers AUTHORIZATION_HEADERS
      detail "show user verification"
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
    end

    get '/show' do
      verification = Verification.find_by(user_id: params.id)
      present verification, with: API::V1::Dashboard::Verifications::Entities::Verification
    end

    desc "add user verification" do
      headers AUTHORIZATION_HEADERS
      detail "add user verification"
    end
    oauth2
    params do
      requires :email, type: String, desc: "Email User"
      optional :ktp_number, type: String, desc: "KTP User"
      optional :ktp_selfie, type: File, desc: "KTP Selfie"
      optional :ktp_photo, type: File, desc: "KTP Photo"
      optional :signature, type: File, desc: "Signature"
    end
    post '/user' do
      user = User.where(email: params.email).first
      error!("User tidak ditemukan", 404) unless user.present?
      verification = Verification.create(user_id: user.id, ktp_number: params.ktp_number, ktp_selfie: params.ktp_selfie, ktp_photo: params.ktp_photo, signature: params.signature)
      verification.verified!
      present verification, with: API::V1::Dashboard::Verifications::Entities::Verification
    end

  end
end
