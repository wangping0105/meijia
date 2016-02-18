class UserSerializer < ActiveModel::Serializer
  include NonullSerializerable

  self.root = false
  attributes :id, :email, :created_at, :name,
    :organization_id, :phone, :role_id, :workflow_state, :job, :tel, :gender,
    :role, :role_json, :department_name, :avatar_url, :departments_manager, :is_super_user,
    :confirmed_phone_at, :pending_report, :superior_id, :superior_name, :organization_name

  #string型属性
  self.stringify_keys = [:email, :created_at, :name, :phone, :workflow_state, :job, :tel, :gender, :superior_name,
                         :role, :department_name, :avatar_url, :confirmed_phone_at, :pending_report, :organization_name]
  #integer型属性
  self.integerify_keys = [:id, :role_id, :organization_id, :superior_id ]
  #float型属性
  self.floatify_keys = []

  class_attribute :includes_opts
  self.includes_opts = [
                         :department,
                         :organization,
                         {roles_user: :role}
                       ]

  def department_name
    "#{object.department.try(:name)}"
  end

  def organization_name
    "#{object.organization.client.try(:shorter_name) || object.organization.try(:name)}"
  end

  def superior_id
    object.superior_id.to_i
  end

  def superior_name
    return "" unless object.superior
    object.superior.name.to_s
  end

  def role_id
    object.role_id.to_i
  end

  def organization_id
    object.organization_id.to_i
  end

  def role
    "#{object.role}"
  end

  def role_json
    if object.role.present?
      {
        id: object.role.id,
        name: "#{object.role}",
        entity_grant_scope: "#{object.role.entity_grant_scope}"
      }
    else
      {}
    end
  end

  def is_super_user
    !! object.is_super_user?
  end

  def departments_manager
    !! object.is_manager?
  end
end
