# for postgres
if node['aps']['database-engine'] == 'postgres'
  default['aps-db']['engine'] = 'postgres'
  default['aps-core']['activiti-app-properties']['datasource.engine'] = 'postgres'
  default['aps-core']['activiti-app-properties']['datasource.driver'] = 'org.postgresql.Driver'
  default['aps-core']['activiti-app-properties']['datasource.url'] = 'jdbc:postgresql://127.0.0.1:5432/process?characterEncoding=UTF-8'
  default['aps-core']['activiti-app-properties']['hibernate.dialect'] = 'org.hibernate.dialect.PostgreSQLDialect'
end

# for any other db
