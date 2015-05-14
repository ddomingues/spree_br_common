require 'highline/import'

# see last line where we create an admin if there is none, asking for email and password
def prompt_for_admin_password
  if ENV['ADMIN_PASSWORD']
    password = ENV['ADMIN_PASSWORD'].dup
    say "Admin Password #{password}"
  else
    password = ask('Password [spree123]: ') do |q|
      q.echo = false
      q.validate = /^(|.{5,40})$/
      q.responses[:not_valid] = 'Invalid password. Must be at least 5 characters long.'
      q.whitespace = :strip
    end
    password = 'spree123' if password.blank?
  end

  password
end

def prompt_for_admin_field(field_description, var_env, default_value)

  if ENV[var_env]
    field = ENV[var_env].dup
    say "Admin #{field_description} #{field}"
  else
    field = ask("#{field_description} [#{default_value}]: ") do |q|
      q.echo = true
      q.whitespace = :strip
    end
    field = default_value if field.blank?
  end

  field

end

def create_admin_user
  attributes = {
      :password => 'fulano',
      :email => 'admin@bluesoft.com.br',
      :first_name => 'admin',
      :last_name => 'admin',
      :phone => '11 12212122',
      :date_of_birth => 22.years.ago,
      :cpf => CPF.generate,
      :password_confirmation => nil,
      :login => nil
  }

  if ENV['AUTO_ACCEPT']
    puts 'User will be created with the properties:'
    puts attributes
  else
    puts 'Create the admin user (press enter for defaults).'
    attributes = {
      :email => prompt_for_admin_field('Email', 'ADMIN_EMAIL', 'spree@example.com'),
      :password => prompt_for_admin_password,
      :first_name => prompt_for_admin_field('First Name', 'ADMIN_FIRST_NAME', 'admin'),
      :last_name => prompt_for_admin_field('Last Name', 'ADMIN_LAST_NAME', 'admin'),
      :phone => prompt_for_admin_field('Phone', 'ADMIN_PHONE', '11 12212122'),
      :date_of_birth => prompt_for_admin_field('Date Of Birth', 'ADMIN_DATE_OF_BIRTH', 22.years.ago),
      :cpf => prompt_for_admin_field('CPF', 'ADMIN_CPF', CPF.generate)
    }
  end

  attributes[:password_confirmation] = attributes[:password]
  attributes[:login] = attributes[:email]

  load 'spree/user.rb'

  if Spree::User.find_by_email(attributes[:email])
    say "\nWARNING: There is already a user with the email: #{attributes[:email]}, so no account changes were made.  If you wish to create an additional admin user, please run rake spree_auth:admin:create again with a different email.\n\n"
  else
    admin = Spree::User.new(attributes)
    if admin.save
      role = Spree::Role.find_or_create_by(name: 'admin')
      admin.spree_roles << role
      admin.save
      admin.generate_spree_api_key!
      say "Done!"
    else
      say "There was some problems with persisting new admin user:"
      admin.errors.full_messages.each do |error|
        say error
      end
    end
  end
end

if Spree::User.admin.empty?
  create_admin_user
else
  puts 'Admin user has already been previously created.'
  if agree('Would you like to create a new admin user? (yes/no)')
    create_admin_user
  else
    puts 'No admin user created.'
  end
end