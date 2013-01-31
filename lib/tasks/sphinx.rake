desc 'Reindex sphinx'
task :sphinx_reindex do
  #`indexer --config /var/www/apps/anithaly-questions/releases/20120212233047/config/production.sphinx.conf --all --rotate`
  exec "indexer --config config/production.sphinx.conf --all --rotate"
end
