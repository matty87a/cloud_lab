# Brief

We require a new terraform structure to manage multiple customers infrastructure hosted in AWS.
Each customer has two AWS accounts: one for non-prod and one for production environments.
Within each account, there must be primary and secondary (DR) regions that host different environments.
Multiple non-prod environments share a single VPC and subnets for cost optimisation, but each environment has its own application infrastructure.
Production RDS database is replicated to a secondary AWS region for disaster recovery purposes, the same replication applies in staging to stagingdr for pre-production deployment testing. 

# Overview

The code has been configured to seperate the state via prod and nonprod environments and apply all areas (e.g dev,staging etc) across each environment from the same codebase to ensure uniformity - another viable option is to sgment this further and seperate state and resource creation by primary/dr or by dev/staging etc.

# Reusabilty

Module calls within the repo are used to ensure reusability of code and to ensure that only the parameters we care about are captured. For this scneario I have used aws provided modules however the module dirs themselves could hold bespoke modules. It would be preferable to host any bespoke modules in a central areas (git repos, tf regsistries etc) rather than in the project code.

Variables drive the code so that there is no need to duplicate effort and that the core resources deployed are unfiform across envs ensuring parity during testing.

# Seperation
State and vairables are separated between nonprod and prod - this could be segmented further into primary/dr or dev/staging/qa/prod. Doing this would required additional backend configs and vars files.
