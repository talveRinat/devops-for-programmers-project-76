VAULT_FILE=group_vars/webservers/vault.yml
RUN=. .venv/bin/activate && 


venv:
	uv venv --python 3.12 .venv

add-ansible: venv
	$(RUN) uv pip install ansible

ansible-roles: add-ansible
	$(RUN) ansible-galaxy install -r requirements.yml

setup-servers:
	$(RUN) ansible-playbook -i inventory.ini setup.yml

deploy-services:
	$(RUN) ansible-playbook -i inventory.ini playbook.yml --tag=deploy

add-datadog:
	$(RUN) ansible-playbook playbook.yml --tags=datadog

encrypt-vault:
	$(RUN) ansible-vault encrypt $(VAULT_FILE)

edit-vault:
	$(RUN) ansible-vault edit $(VAULT_FILE)

decrypt-vault:
	$(RUN) ansible-vault decrypt $(VAULT_FILE)

generate-secret:
	python3 -c "import secrets; print(secrets.token_hex(64))"

.PHONY: venv, add-ansible, install-deps, deploy, encrypt-vault, edit-vault, decrypt-vault, generate-secret