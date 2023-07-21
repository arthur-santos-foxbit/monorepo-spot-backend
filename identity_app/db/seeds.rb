Identity.transaction do
  ap 'Creating development identities...'

  (1..9).each do |i|
    SignupService.new(
      {
        email: "email#{i}@email.com",
        cid: "00000#{i}",
        password: "!@#123QWEqwe#{i}"
      }
    ).call
  end

  Identity.create!(
    {
      email: 'arthur.santos+pro.homolog@foxbit.com.br',
      cid: '963945',
      encrypted_password: 'a6895a4bf774da729976a4f0c6f409c7343839cc675cd7a004f5948fb933872a' # Imported from starfox stage
    }
  )

  ap 'Development identities created!'
end
