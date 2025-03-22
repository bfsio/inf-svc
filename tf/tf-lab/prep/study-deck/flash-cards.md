### Study Deck

#### What is IaC

- A blueprint and inventory of your infrastructure that serves as a configuration script to automate creating, updating, or destroying cloud Infrastructure, that can be shared and versioned.

#### Is JS, Python, Ruby, etc. as IaC imperative or declarative?

- Imperative. It is less verbose and prone to a non-idempotent state.

#### Is YAML, JSON, and XML as IaC declarative or imperative?

- Declarative, verbose and indempotent.

#### What is a infrastructure lifecycle?

- A number of clearly defined and distinct work phases used by DevOps Engineers to plan, design, build, test, maintain, and decom cloud infrastructure.

#### What is idempotent?

- No matter how many times you run a function, you will always end up with the expected state.

#### What is provisioning?

- Provisioning is when you launch a cloud service and configure it.

#### How can we detect configuration drift?

- Use a compliance tool such as AWS Config or Azure Policies, utilize functionality such as AWS CloudFormation Drift Detection, store the expected state in a state file such as Terraform state.