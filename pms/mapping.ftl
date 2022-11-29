<#assign jpath=handlers("JsonHandler")>
<#assign dataset=providers("URLProvider", { "url" : "https://raw.githubusercontent.com/oeg-upm/cogito_data_repository/main/pms/example.json" })>

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix data: <http://data.cogito.iot.linkeddata.es/resources/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix facility: <https://cogito.iot.linkeddata.es/def/facility#> .
@prefix project: <http://data.cogito.iot.linkeddata.es/resources/project/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .


project:[=jpath.filter('$.project_id', dataset)]
    a facility:Project ;
    facility:projectID "[=jpath.filter('$.project_id', dataset)]"^^<http://www.w3.org/2001/XMLSchema#string> .

