Generate secret password with given criteria
Usage:
{{ include "utils.secret.password.generate" (dict "secret" "secret-name" "key" "keyName" "providedValues" (list "path.to.password1" "path.to.password2") "length" 10 "strong" false "chartName" "chartName" "context" $) }}

Params:
  - secret - String - Required - Name of the 'Secret' resource where the password is stored.
  - key - String - Required - Name of the key in the secret.
  - providedValues - List<String> - Required - The path to the validating value in the values.yaml, e.g: "mysql.password". Will pick first parameter with a defined value.
  - length - int - Optional - Length of the generated random password.
  - strong - Boolean - Optional - Whether to add symbols to the generated random password.
  - chartName - String - Optional - Name of the chart used when said chart is deployed as a subchart.
  - context - Context - Required - Parent context.
  - lower - Boolean - Optional - Whether to lower all the case
*/}}
{{- define "common.secrets.passwords.manage" -}}

{{- $password := "" }}
{{- $subchart := "" }}
{{- $chartName := default "" .chartName }}
{{- $passwordLength := default 10 .length }}
{{- $providedPasswordKey := include "common.utils.getKeyFromList" (dict "keys" .providedValues "context" $.context) }}
{{- $providedPasswordValue := include "common.utils.getValueFromKey" (dict "key" $providedPasswordKey "context" $.context) }}
{{- $secret := (lookup "v1" "Secret" $.context.Release.Namespace .secret) }}
{{- if $secret }}
  {{- if index $secret.data .key }}
  {{- $password = index $secret.data .key }}
  {{- end -}}
{{- else if $providedPasswordValue }}
  {{- $password = $providedPasswordValue | toString | b64enc | quote }}
{{- else }}

  {{- if .context.Values.enabled }}
    {{- $subchart = $chartName }}
  {{- end -}}

  {{- $requiredPassword := dict "valueKey" $providedPasswordKey "secret" .secret "field" .key "subchart" $subchart "context" $.context -}}
  {{- $requiredPasswordError := include "common.validations.values.single.empty" $requiredPassword -}}
  {{- $passwordValidationErrors := list $requiredPasswordError -}}
  {{- include "common.errors.upgrade.passwords.empty" (dict "validationErrors" $passwordValidationErrors "context" $.context) -}}
  
  {{- if .strong }}
    {{- $subStr := list (lower (randAlpha 1)) (randNumeric 1) (upper (randAlpha 1)) | join "_" }}
    {{- $password = randAscii $passwordLength }}
    {{- $password = regexReplaceAllLiteral "\\W" $password "@" | substr 5 $passwordLength }}
    {{- $password = printf "%s%s" $subStr $password | toString | shuffle | b64enc | quote }}
  {{- else }}
    {{- $password = randAlphaNum $passwordLength | b64enc | quote }}
  {{- end }}
{{- end -}}
{{- printf "%s" $password -}}
{{- end -}}