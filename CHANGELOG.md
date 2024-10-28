# Changelog

**0.3.0**

- add `additionalLabels` parameters

**0.2.26**

- treat `postMatchConfig` as string rather than array

**0.2.25**

- add `preMatchConfig`
- change `extraConfig` into `postMatchConfig`

**0.2.24**

- add priorityClassName parameters
- expose prometheus port and configure livenessProbe

**0.2.23**

- update image tag override & bump default image tag

**0.2.22**

- add extraVolumes & extraVolumeMounts parameters

**0.2.18**

- Add tini and auto reload configmap

**0.2.17**

- Fix regex mapping

**0.2.16**

- Add logic to handle log with cri-o format

**0.2.15**

- Add cluster_name value from kubernetes

**0.2.14**

- Fix typo for ephemeralStorage key
- Set true for read_from_head default value

**0.2.13**

- Adjust default value for cpu resource request limit, change default value for request is 500m and for limit is 2

**0.2.12**

- Add ephemeral-storage resource request limit, with default value for request is 4Gi and for limit is 6Gi
- Add cpu resource request limit, with default value for request is 512Mi and for limit is 1Gi
- Adjust default value for memory resource request limit, change default value for request is 1Gi and for limit is 2Gi
- Add supports for read_from_head on defaultAppOptions and default value is false

**0.2.11**

- Add default app options

**0.2.10**

- Make RollingUpdate behaviour default when updating agent

**0.2.9**

- Add supports for tolerations, node selector and affinity configurations

**0.2.8**

- Re-introduce kubernetes filter, we should only remove the annotation match instead of the whole filter in the previous version.

**0.2.7**

- Remove the needs for adding annotation for barito agent to start capturing logs

**0.2.6**

- Parameterize configmap so that multiple td-agent-barito-kubernetes can be installed

**0.2.5**

- Fix typo, supposed to be `fluentd.active = true` annotations

**0.2.4**

- Support both `barito.active = true` and `fluent.active = true` annotations

**0.2.3**

- Automatically roll deployments when configmaps or secrets change using checksum in DaemonSet annotation
