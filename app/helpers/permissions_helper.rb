module PermissionsHelper
  def workspace_permissions(workspace)
    workspace_policy = Pundit.policy(current_session, [:admin, workspace])
    user_policy = Pundit.policy(current_session, [:admin, User])
    upload_policy = Pundit.policy(current_session, [:admin, Upload])
    template_policy = Pundit.policy(current_session, [:admin, Template])
    entity_policy = Pundit.policy(current_session, [:admin, Entity])

    return {
      view_workspace: workspace_policy.show?,
      update_workspace: workspace_policy.update?,
      destroy_workspace: workspace_policy.destroy?,
      list_users: user_policy.index?,
      invite_users: user_policy.invite?,
      list_uploads: upload_policy.index?,
      create_uploads: upload_policy.create?,
      list_templates: template_policy.index?,
      create_templates: template_policy.create?,
      list_entities: entity_policy.index?,
      create_entities: entity_policy.create?
    }
  end

  def user_permissions(user)
    user_policy = Pundit.policy(current_session, [:admin, user])

    return {
      view_user: user_policy.show?,
      update_user: user_policy.update?,
      destroy_user: user_policy.destroy?
    }
  end

  def upload_permissions(upload)
    upload_policy = Pundit.policy(current_session, [:admin, upload])

    return {
      view_upload: upload_policy.show?,
      update_upload: upload_policy.update?,
      destroy_upload: upload_policy.destroy?
    }
  end

  def template_permissions(template)
    template_policy = Pundit.policy(current_session, [:admin, template])
    entity_policy = Pundit.policy(current_session, [:admin, Entity])

    return {
      view_template: template_policy.show?,
      update_template: template_policy.update?,
      destroy_template: template_policy.destroy?,
      list_entities: entity_policy.index?,
      create_entities: entity_policy.create?
    }
  end

  def entity_permissions(entity)
    entity_policy = Pundit.policy(current_session, [:admin, entity])

    return {
      view_entity: entity_policy.show?,
      update_entity: entity_policy.update?,
      destroy_entity: entity_policy.destroy?
    }
  end
end
