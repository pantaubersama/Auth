class API::V1::Verifications::Resources::Verifications < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "me" do
    desc 'My verification' do
      detail "[My verification"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/verifications" do
      present :user, current_user.verification, with: API::V1::Verifications::Entities::Verification
    end 
  end

  resource "verifications" do
    desc '[1] Verify KTP' do
      detail "[1] Verify KTP"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :ktp_number, type: String, desc: "No. KTP"
    end
    oauth2
    put "/ktp_number" do
      response = current_user.verification.update_attribute(:ktp_number, params[:ktp_number])
      present :user, current_user.verification, with: API::V1::Verifications::Entities::Verification
    end 

    desc '[2] Verify KTP Selfie' do
      detail "[2] Verify KTP Selfie"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :ktp_selfie, type: File, desc: "Selfie with KTP"
    end
    oauth2
    put "/ktp_selfie" do
      params[:ktp_selfie] = prepare_file(params[:ktp_selfie]) if params[:ktp_selfie].present?
      response = current_user.verification.update_attribute(:ktp_selfie, params[:ktp_selfie])
      present :user, current_user.verification, with: API::V1::Verifications::Entities::Verification
    end

    desc '[3] Verify KTP Photo' do
      detail "[3] Verify KTP Photo"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :ktp_photo, type: File, desc: "KTP Photo"
    end
    oauth2
    put "/ktp_photo" do
      params[:ktp_photo] = prepare_file(params[:ktp_photo]) if params[:ktp_photo].present?
      response = current_user.verification.update_attribute(:ktp_photo, params[:ktp_photo])
      present :user, current_user.verification, with: API::V1::Verifications::Entities::Verification
    end

    desc '[4] Verify Signature' do
      detail "[4] Verify Signature"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :signature, type: File, desc: "Signature photo"
    end
    oauth2
    put "/signature" do
      params[:signature] = prepare_file(params[:signature]) if params[:signature].present?
      response = current_user.verification.update_attribute(:signature, params[:signature])
      present :user, current_user.verification, with: API::V1::Verifications::Entities::Verification
    end

  end
end