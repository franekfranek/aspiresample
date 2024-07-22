// var builder = DistributedApplication.CreateBuilder(args);

// var cache = builder.AddRedis("crm-cache");

// var apiService = builder.AddProject<Projects.AspireSample_ApiService>("crm-apiservice");

// builder.AddProject<Projects.AspireSample_Web>("crm-webfrontend")
//     .WithExternalHttpEndpoints()
//     .WithReference(cache)
//     .WithReference(apiService);

// builder.Build().Run();
var builder = DistributedApplication.CreateBuilder(args);

var cache = builder.AddRedis("crm-cache");

var secrets = builder.ExecutionContext.IsPublishMode
    ? builder.AddAzureKeyVault("secrets")
    : builder.AddConnectionString("secrets");

// Add the locations database.
var locationsdb = builder.AddPostgres("db").AddDatabase("locations");

// Add the locations database reference to the API service.
var apiservice = builder.AddProject<Projects.AspireSample_ApiService>("apiservice")
    .WithReference(locationsdb);

builder.AddProject<Projects.AspireSample_Web>("webfrontend")
    .WithReference(cache)
    .WithReference(apiservice)
    .WithReference(secrets);

builder.AddBicepTemplate(
    name: "storage",
    bicepFile: "infra/storage.bicep");


builder.Build().Run();