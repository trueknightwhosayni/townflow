user = User.where(email: 'admin@townflow.io').first_or_create!(password: '11111111')
user.add_role Role::SUPERUSER

if Group.count == 0
  g = Group.create!(title: 'Administrators', owner: user)
  g.add_role Role::SUPERUSER
  g.users << user
end
