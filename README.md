# ansible-containerized [![](https://images.microbadger.com/badges/image/varunchopra/ansible.svg)](https://microbadger.com/images/varunchopra/ansible "Get your own image badge on microbadger.com")

## Usage

* ### Jenkins
    Use `varunchopra/ansible` for running Ansible inside containers with Jenkins.
    
    Sample pipeline:
    
    ```
    pipeline {
      agent none
      stages {
        stage('Ansible') {
          agent {
            docker {
              image 'varunchopra/ansible:latest'
              args '--user ansible'
            }
          steps {
            ansiblePlaybook(playbook: 'main.yml', disableHostKeyChecking: true)
          }
        }
      }
    }
    ```

* ### Ansible Playbooks as Containers

    Usable as a base image for building containers for Ansible workflows:
  
    Sample `Dockerfile`:

    ```
    FROM varunchopra/ansible:latest

    USER root

    COPY docker-entrypoint.sh /entrypoint.sh

    ADD workspace /workspace

    RUN chmod +x /entrypoint.sh; \
        chown -R ansible:ansible /workspace;

    USER ansible

    ENTRYPOINT ["/entrypoint.sh"]
    ```
    
