<#assign jpath=handlers("JsonHandler")>
<#assign dataset=providers("URLProvider", { "url" : "https://raw.githubusercontent.com/oeg-upm/cogito_data_repository/main/pms/example.json" })>

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix data: <http://data.cogito.iot.linkeddata.es/resources/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix facility: <https://cogito.iot.linkeddata.es/def/facility#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix process_data: <http://data.cogito.iot.linkeddata.es/resources/process/> .
@prefix project: <http://data.cogito.iot.linkeddata.es/resources/project/> .
@prefix task: <http://data.cogito.iot.linkeddata.es/resources/task/> .
@prefix res_type_req: <http://data.cogito.iot.linkeddata.es/resources/resource_type_requirement/> .
@prefix res_type: <http://data.cogito.iot.linkeddata.es/resources/resource_type/> .
@prefix resource: <https://cogito.iot.linkeddata.es/def/resource#> .


project:[=jpath.filter('$.project_id', dataset)]
    a facility:Project ;
    facility:isRelatedToProcess data:[=jpath.filter('$.process_id', dataset)] ;
    facility:projectID "[=jpath.filter('$.project_id', dataset)]"^^<http://www.w3.org/2001/XMLSchema#string> .

<#list jpath.filter('$.tasks[*]',dataset)>
    <#items as task>
        task:[=jpath.filter('$.project_id', dataset)]_[=jpath.filter('$.process_id', dataset)]_[=jpath.filter('$.id', task)]
        a process:Task ;
        facility:isRelatedToProject project:[=jpath.filter('$.project_id', dataset)] ;
        process:taskId '[=jpath.filter('$.id', task)]' ;
        process:hasName '[=jpath.filter('$.name', task)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
        process:plannedStartDate '[=jpath.filter('$.start_time', task)]'^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
        process:plannedEndDate '[=jpath.filter('$.end_time', task)]'^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
        <#assign res_list = jpath.filter('$.resource_list[*]', task)>
        <#if res_list?is_sequence>
           <#list res_list as res>
               process:hasResourceTypeRequirement res_type_req:[=jpath.filter('$.name', res)] .

            res_type_req:[=jpath.filter('$.name', res)] 
                a process:ResourceTypeRequirement ;
                process:quantityNeeded [=jpath.filter('$.quantity_needed', res)] ;
                process:relatesToResourceType res_type:[=jpath.filter('$.name', res)] .

            res_type:[=jpath.filter('$.name', res)]
                a resource:ResourceType.
           </#list>
        <#else>
               process:hasResourceTypeRequirement res_type_req:[=jpath.filter('$.name', res_list)] .

            res_type_req:[=jpath.filter('$.name', res_list)] 
                a process:ResourceTypeRequirement ;
                process:quantityNeeded [=jpath.filter('$.quantity_needed', res_list)] ;
                process:relatesToResourceType res_type:[=jpath.filter('$.name', res_list)] .

            res_type:[=jpath.filter('$.name', res_list)]
                a resource:ResourceType.
        </#if>
    </#items>
</#list>

