#' 
#' @title ds.listDisclosureSettings
#' @description Lists current values for disclosure control filters in all Opal servers
#' @details This function lists out the current values of the eight disclosure filters in each of
#' the Opal servers specified by datasources. Eight filters can currently be set:
#' (1) nfilter.tab, the minimum non-zero cell count allowed in any cell if a contingency table is
#' to be returned. This applies to one dimensional and two dimensional tables of counts tabulated
#' across one or two factors and to tables of a mean of a quantitative variable tabulated across a
#' factor. Default usually set to 3 but a value of 1 (no limit) may be necessary, particularly if
#' low cell counts are highly probable such as when working with rare diseases. Five is also a
#' justifiable choice to replicate the most common threshold rule imposed by data releasers
#' worldwide; but it should be recognised that many census providers are moving to ten - but the
#' formal justification of this is little more than 'it is safer' and everybody is scared of
#' something going wrong - in practice it is very easy to get round any block and so it is
#' debatable whether the scientific cost outweighs the imposition of any threshold.
#' (2) nfilter.subset, the minimum non-zero count of observational units (typically individuals) in
#' a subset. Typically defaulted to 3.
#' (3) nfilter.glm, the maximum number of parameters in a regression model as a proportion of the
#' sample size in a study. If a study has 1000 observational units (typically individuals) being
#' used in a particular analysis then if nfilter.glm is set to 0.37 (its default value) the maximum
#' allowable number of parameters in a model fitted to those data will be 370. This disclosure
#' filter protects against fitting overly saturated models which can be disclosive. The choice of
#' 0.37 is entirely arbitrary.
#' (4) nfilter.string, the maximum length of a string argument if that argument is to be subject to
#' testing of its length. Default value = 80. The aim of this nfilter is to make it difficult for
#' hackers to find a way to embed malicious code in a valid string argument that is actively
#' interpreted.
#' (5) nfilter.stringShort to be used when a string must be specified but that when valid that
#' string should be short.
#' (6) nfilter.kNN applies to graphical plots based on working with the k nearest neighbours of
#' each point. nfilter.kNN specifies the minimum allowable value for the number of nearest
#' neighbours used, typically defaulted to 3.
#' (7) nfilter.levels specifies the maximum number of unique levels of a factor variable that can
#' be disclosed to the client. In the absense of this filter a user can convert a numeric variable
#' to a factor and see its unique levels which are all the distinct values of the numeric vector. To
#' prevent such disclosure we set this threshold to 0.33 which ensures that if a factor has unique
#' levels more than the 33% of its actual length, then the levels do not returned to the client.
#' (8) nfilter.noise specifies the minimum level of noise added in some variables mainly used for
#' data visualizations. The default value is 0.10 which means that the noise added to a given
#' variable, follows a normal distribution with zero mean and variance equal to 10% of the actual
#' variance of the given variable. Any value greated than this threshold can reduce the risk of
#' disclosure.
#' @param datasources a list of the particular Opal servers to have their values listed
#' @return a list containing the current settings of the nfilters in each study specified
#' @author Paul Burton, Demetris Avraam for DataSHIELD Development Team
#' @export
#' @examples
#' \dontrun{
#' #WORKING EXAMPLES NOT PROVIDED (MULTIPLE OPALS AND R SESSIONS MAKE THIS DIFFICULT)
#' ##Client-side function call to list current disclosure settings in all Opal servers
#' #ds.listDisclosureSettings()
#' #
#' ##Equivalent call directly to server-side function to list current disclosure settings in all
#' ##Opal servers not recommended unless you are experienced DataSHIELD user
#' #ds.look("listDisclosureSettingsDS()")
#' #
#' ##Call to client-side function and save output as an R object to refer to later
#' #current.DisclosureSettings<-ds.listDisclosureSettings()
#' ##Interrogate ouput later
#' #current.DisclosureSettings[[1]]
#' #
#' #Restrict call to list disclosure settings only to the first, or second Opals
#' #ds.listDisclosureSettings(datasources=opals.em[1])
#' #ds.listDisclosureSettings(datasources=opals.em[2])
#' #
#' }
#' 
ds.listDisclosureSettings <- function(datasources=NULL){
  # if no opal login details are provided look for 'opal' objects in the environment
  if(is.null(datasources)){
    datasources <- findLoginObjects()
  }

  # CALL THE MAIN SERVER SIDE FUNCTION
  calltext <- call("listDisclosureSettingsDS")
  Opal.disclosure.settings <- opal::datashield.aggregate(datasources, calltext)

  # RETURN COMPLETION INFORMATION TO .GlobalEnv
  return(list(Opal.disclosure.settings=Opal.disclosure.settings))
}
# ds.listDisclosureSettings
