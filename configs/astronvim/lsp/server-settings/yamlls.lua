return {
  settings = {
    yaml = {
      completion = true,
      -- add tags to support CloudFormation templates
      customTags = {
        "!Fn scalar",
        "!And scalar",
        "!If scalar",
        "!Not scalar",
        "!Equals scalar",
        "!Or scalar",
        "!FindInMap sequence",
        "!Base64 scalar",
        "!Cidr scalar",
        "!Ref scalar",
        "!Ref scalar",
        "!Sub scalar",
        "!GetAtt scalar",
        "!GetAZs scalar",
        "!ImportValue scalar",
        "!Select scalar",
        "!Split scalar",
        "!Join sequence",
      },
      format = {
        enable = true,
        printWidth = 120,
      },
      hover = true,
      schemas = {
        ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["https://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        ["https://json.schemastore.org/rustfmt.json"] = "rustfmt.toml",
      },
      schemaStore = {
        enable = true,
      },
    },
  },
}
