# install.packages("remotes")
# remotes::install_github("OuhscBbmc/REDCapR")
path_credential <- "redcapcon_2023_redcap_r_workshop/data-private/credentials.csv"
credential  <- REDCapR::retrieve_credential_local(path_credential, 1L)

if (FALSE) {
  View(REDCapR::redcap_metadata_read(
    redcap_uri  = credential$redcap_uri,
    token       = credential$token
  )$data)

  REDCapR::redcap_event_instruments(
    redcap_uri  = credential$redcap_uri,
    token       = credential$token
  )$data
}

ds_mishmash <-
  REDCapR::redcap_read(
    redcap_uri  = credential$redcap_uri,
    token       = credential$token
  )$data

ds_pt <-
  REDCapR::redcap_read(
    redcap_uri  = credential$redcap_uri,
    token       = credential$token,
    forms       = c("infusion_sequence", "demographics"),
    events      = "screening__enrollm_arm_1"
  )$data

ds_med <-
  REDCapR::redcap_read(
    redcap_uri    = credential$redcap_uri,
    token         = credential$token,
    fields        = c("medhx_conditionhx", "medhx_start_date", "medhx_grade_1"),
    events        = "screening__enrollm_arm_1",
    filter_logic  = "[medhx_conditionhx] != ''"
  )$data
