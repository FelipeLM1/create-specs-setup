# SDD instance configuration — contract_version: 1
contract_version: 1

project:
  name: "{{PROJECT_NAME}}"
  specs_repo_slug: "{{SPECS_REPO_SLUG}}"
  language: "{{PROJECT_LANGUAGE}}"
  git_url: "{{PROJECT_GIT_URL}}"
  owner: "{{PROJECT_OWNER}}"
  maturity: "{{PROJECT_MATURITY}}"  # greenfield | production

repos:
  api: "{{API_REPO}}"
  spa: "{{SPA_REPO}}"
  extra: []  # ex.: [{ name: "workers", path: "my-project-workers" }]

business_rules:
  primary_store: "specs_repo"
  wiki:
    enabled: {{WIKI_ENABLED}}
    base_url: "{{WIKI_BASE_URL}}"
    host_repo: "{{WIKI_HOST_REPO}}"
    page_pattern: "RN{code}"

gitlab:
  enabled: {{GITLAB_ENABLED}}
  base_url: "{{GITLAB_BASE_URL}}"
  namespace: "{{GITLAB_NAMESPACE}}"

workflow:
  hotfix_outside_specs: {{HOTFIX_OUTSIDE_SPECS}}
  sprint_task_split_default: "{{SPRINT_TASK_SPLIT}}"  # single | backend_frontend
  task_templates: "{{TASK_TEMPLATES_MODE}}"  # default | custom

prototype:
  enabled: {{PROTOTYPE_ENABLED}}
  spa_source_repo: "{{SPA_REPO}}"
  folder: "prototypes"
  dev_port: {{PROTOTYPE_DEV_PORT}}
  shared_components_path: "{{SPA_SHARED_COMPONENTS_PATH}}"
  # Cada protótipo isolado em src/app/feature/{task_ref}-{slug}/
  feature_base_path: "src/app/feature"
  feature_folder_pattern: "{task_ref}-{slug}"  # ex.: 100-listagem-usuario, 101-login

skills:
  guide_name: "{{GUIDE_SKILL_NAME}}"

setup:
  date: "{{SETUP_DATE}}"
  source: "create-specs-setup"
