# IBM DataPower GitOps

This repository was created or modified by an IBM DataPower Gateway. One or more domains / templates have been committed by DataPower and will take the following form in this repository:

```
/datapower
├── domain1
│   ├── config
│   └── local
├── domain2
│   ├── config
│   └── local
└── templates
```

For any domain with the GitOps object configured, the following directories will be created and used for GitOps processing on DataPower:

```
temporary:///
  gitops/
    config/
      in/           # DataPower puts configuration here on gitops-read, watched by config-sequence.
      out/          # DataPower puts templated configuration here to be committed to git on gitops-write.
      staging/      # DataPower pulls source from git here to resolve any templated fields.
    templates/
      in/           # DataPower pulls templates from git here, watched by config-sequence.
      out/          # DataPower puts templates here on gitops-write-template to be committed to git.
```

GitOps converts persisted configuration, within a domain, to JSON and operates on the document using JSONata queries and transforms. All git operations and templating are performed on DataPower with the following Action object commands.

### GitOps Read (`gitops-read`)

GitOps Read is an Action object responsible for pulling new configuration from git based on the GitOps object configuration. The source domain configuration JSON and any configured templates will be pulled from the remote git repository according to the commit identifer in the GitOps object, which can be a branch, tag, or commit. The templated values from the inbound JSON are then resolved. The executable configuration is placed into a configuration sequence tracked location to be committed and persisted to the domain's configuration.

### GitOps Write (`gitops-write`)

GitOps Write is an Action object responsible for taking persisted configuration from the domain, templating it with the template-policies configured on the GitOps object and writing to the remote git repository. Commits created by DataPower use the `name` and `email` configured on the GitOps object.

This Action object is only available when GitOps is configured in `read-write` mode.

### GitOps Write Template (`gitops-write-template`)

GitOps Write Template is an Action object responsible commiting a single template and pushing to the remote git repository. Once written, the template may be configured as a remote template by any other domain or DataPower. Similar to `gitops-write`, commits created by DataPower use the `name` and `email` configured on the GitOps object.

This Action object is only available when GitOps is configured in `read-write` mode.
