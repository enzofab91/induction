describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user) }

  it 'successfully connects to cable' do
    connect '/cable', headers: auth_headers

    expect(connection.current_user).to eq user
  end
end
