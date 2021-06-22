require 'rails_helper'

describe TargetsCleanupJob, type: :job do
  subject(:execute_job) { TargetsCleanupJob.perform_now }

  let(:user) { create :user }
  let(:expired_date) { Time.zone.now - 8 }
  let!(:expired_target) { create :target, created_at: expired_date, user: user }
  let!(:active_target) { create :target, user: user }

  it { expect { execute_job }.not_to raise_error }

  it 'deletes targets after seven days of being created' do
    expect {
      subject
    }.to change(Target, :count).by(-1)
  end

  it 'deletes a target if creation date is more than seven days from now' do
    subject

    expect(Target.all).not_to include(expired_target)
  end

  it 'does not deletes a target if creation date is less than seven days from now' do
    subject

    expect(Target.all).to include(active_target)
  end

  it 'schedules to run again in one week after current execution ends' do
    expect {
      subject
    }.to have_enqueued_job(TargetsCleanupJob)
  end
end
