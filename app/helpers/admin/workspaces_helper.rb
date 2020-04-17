module Admin::WorkspacesHelper
  def workspace_permissions(workspace)
    workspace_policy = Pundit.policy(current_session, [:admin, workspace])
    user_policy = Pundit.policy(current_session, [:admin, User])
    template_policy = Pundit.policy(current_session, [:admin, Template])
    entity_policy = Pundit.policy(current_session, [:admin, Entity])

    return {
      view_workspace: workspace_policy.show?,
      update_workspace: workspace_policy.update?,
      destroy_workspace: workspace_policy.destroy?,
      list_users: user_policy.index?,
      invite_users: user_policy.invite?,
      list_templates: template_policy.index?,
      create_templates: template_policy.create?,
      list_entities: entity_policy.index?,
      create_entities: entity_policy.create?
    }
  end
end
