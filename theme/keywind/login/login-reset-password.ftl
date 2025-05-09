<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "features/labels/username.ftl" as usernameLabel>

<#assign usernameLabel><@usernameLabel.kw /></#assign>

<#if captchaRequired??>
  <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
</#if>

<@layout.registrationLayout
  displayInfo=true
  displayMessage=!messagesPerField.existsError("username")
  ;
  section
>
  <#if section="header">
    ${msg("emailForgotTitle")}
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">
      <@input.kw
        autocomplete=realm.loginWithEmailAllowed?string("email", "username")
        autofocus=true
        invalid=messagesPerField.existsError("username")
        label=usernameLabel
        message=kcSanitize(messagesPerField.get("username"))
        name="username"
        type="text"
        value=(auth?has_content && auth.showUsername())?then(auth.attemptedUsername, '')
      />
      <#if captchaRequired??>
        <div class="cf-turnstile" data-sitekey="${captchaSiteKey}" data-action="${captchaAction}" data-language="${captchaLanguage}"></div>
      </#if>
      <@buttonGroup.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doSubmit")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  <#elseif section="info">
    ${msg("emailInstruction")}
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>
