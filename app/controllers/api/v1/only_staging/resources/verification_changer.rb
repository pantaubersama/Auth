class API::V1::OnlyStaging::Resources::VerificationChanger < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "only_staging" do
    desc 'Approve my verification' do
      headers AUTHORIZATION_HEADERS
      detail "Approve my verification"
    end
    oauth2
    post "/approve_me" do
      current_user.verification.update_attribute(:approved, true)
      present true
    end
  end

  namespace "only_staging" do
    desc 'Un-Approve my verification' do
      headers AUTHORIZATION_HEADERS
      detail "Un-Approve my verification"
    end
    oauth2
    post "/unapprove_me" do
      current_user.verification.update_attribute(:approved, false)
      present true
    end
  end
end
    