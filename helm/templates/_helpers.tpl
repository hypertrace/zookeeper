{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "zookeeper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "zookeeper.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "zookeeper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "zookeeper.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "zookeeper.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- /*
zookeeper.labels.standard prints the standard zookeeper Helm labels.
The standard labels are frequently used in metadata.
*/ -}}
{{- define "zookeeper.labels.standard" -}}
app: {{ template "zookeeper.name" . }}
chart: {{ template "zookeeper.chart" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
{{- end -}}

{{- /*
Form the zookeeper headless service name
*/ -}}
{{- define "zookeeper.headless.service" -}}
{{- printf "%s-headless" (include "zookeeper.fullname" .) | trunc 63 }}
{{- end -}}

{{- define "zookeeperservice.image" -}}
  {{- if and .Values.image.tagOverride  -}}
    {{- printf "%s:%s" .Values.image.repository .Values.image.tagOverride }}
  {{- else -}}
    {{- printf "%s:%s" .Values.image.repository .Chart.AppVersion }}
  {{- end -}}
{{- end -}}