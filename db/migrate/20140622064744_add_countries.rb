class AddCountries < ActiveRecord::Migration
  def change
    [
      'Brunei',
      'Cambodia',
      'East Timor',
      'Indonesia',
      'Laos',
      'Malaysia',
      'Myanmar',
      'Philippines',
      'Singapore',
      'Thailand',
      'Vietnam',
      'Others'
    ].each do |country|
      Country.create name: country
    end
  end
end
