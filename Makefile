VAULT_FILE=group_vars/webservers/vault.yml
RUN=. .venv/bin/activate && 


.PHONY: venv
venv:
	uv venv --python 3.12 .venv

.PHONY: add-ansible
add-ansible: venv
	$(RUN) uv pip install ansible

.PHONY: install-deps
install-deps: add-ansible
	$(RUN) ansible-galaxy install -r requirements.yml
	$(RUN) ansible-playbook -i inventory.ini playbook.yml

.PHONY: generate-secret
generate-secret:
	python3 -c "import secrets; print(secrets.token_hex(64))"

.PHONY: deploy
deploy:
	$(RUN) ansible-playbook -i inventory.ini deploy.yml --tag=deploy

prepare-servers:
	$(RUN) ansible-playbook deploy.yml --tags=prepare-servers

.PHONY: encrypt-vault
encrypt-vault:
	$(RUN) ansible-vault encrypt $(VAULT_FILE)

.PHONY: edit-vault
edit-vault:
	$(RUN) ansible-vault edit $(VAULT_FILE)

.PHONY: decrypt-vault
decrypt-vault:
	$(RUN) ansible-vault decrypt $(VAULT_FILE)

.PHONY: ssh-add
ssh-add	:
	ssh-add ~/.ssh/id_rsa