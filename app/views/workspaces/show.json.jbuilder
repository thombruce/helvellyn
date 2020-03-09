json.partial! "workspaces/workspace", workspace: @workspace

json.content_types @workspace.content_types, partial: "content_types/content_type", as: :content_type
