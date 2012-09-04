module ApiHelper
  attr_reader :cities, :all_cats, :weekend

  def initialize
    # ruby time: for date
    @weekend = {
      'friday' => {'day' => "Fri Jun 01 01:00:33 2011", 'night' => "Fri Jun 01 23:48:33 2011"},
      'saturday' => {'day' => "Sat Jun 02 01:00:33 2011", 'night' => "Sat Jun 02 23:48:33 2011"},
      'sunday' =>  {'day' => "Sun Jun 03 01:00:33 2011", 'night' => "Sun Jun 03 23:48:33 2011"},
      'all' => {'day' => "Fri Jun 01 01:00:33 2011", 'night' => "Sun Jun 03 23:48:33 2011"}
    }

    @all_cats = {
      'conference' => '4',
      'conventions' => '4',
      'entertainment' => '7',
      'fundraisers' => '3',
      'meetings' => '4',
      # 'other' => '13',
      'performances' => '5',
      # 'reunions' => '13',
      'sales' => '6',
      'seminars' => '4',
      'social' => '7',
      'sports' => '8',
      'tradeshows' => '4',
      'travel' => '9',
      'religion' => '3',
      'fairs' => '10',
      'food' => '11',
      'music' => '12',
      'recreation' => '8'
    }

  end

  def self.cities
    # list of availalbe cities and needed attributes for each api
    @cities = {
      'la' => {'lat'=>34.052234,'lon'=>'-118.243685','groupon'=>'los-angeles','zip'=>90012,'radius'=>50,'radius2'=>13,'zoom'=>12,'count'=>(550..650).to_a.shuffle.first},
      'nyc' => {'lat'=>40.737059,'lon'=>-73.972492,'groupon'=>'new-york','zip'=>'11222','radius'=>40,'radius2'=>11,'count'=>(550..650).to_a.shuffle.first},
      'dc' => {'lat'=>38.89464,'lon'=>-76.999569,'groupon'=>'washington-dc','zip'=>20002,'radius'=>40,'radius2'=>11},
      'chicago' => {'lat'=>41.881928,'lon'=>-87.644547,'groupon'=>'chicago','zip'=>60661,'radius'=>5,'radius2'=>11,'count'=>(450..550).to_a.shuffle.first},
      'sf' => {'lat'=>37.750943,'lon'=>-122.378499,'groupon'=>'san-francisco','zip'=>94117,'zip1'=>94601,'radius'=>20,'radius2'=>11,'zoom'=>12,'count'=>(550..650).to_a.shuffle.first},
      'ph' => {'lat'=>40.012545,'lon'=>-75.148701,'groupon'=>'philadelphia','zip'=>19140,'radius'=>20,'radius2'=>11},
      'seattle' => {'lat'=>47.60621,'lon'=>-122.33207,'groupon'=>'seattle','zip'=>98101,'radius'=>50,'radius2'=>20},
      'portland' => {'count'=>243,'lat'=>45.52345,'lon'=>-122.67621,'groupon'=>'portland','zip'=>97209,'radius'=>50,'radius2'=>20},
      'sj' => {'lat'=>37.33939,'lon'=>-121.89496,'groupon'=>'san-jose','zip'=>95112,'radius'=>70,'radius2'=>20},
      'sd' => {'lat'=>32.702883,'lon'=>-117.15725,'groupon'=>'san-diego','zip'=>92101,'radius'=>60,'radius2'=>20},
      'miami' => {'lat'=>25.78897,'lon'=>-80.17744,'groupon'=>'miami','zip'=>33125,'radius'=>40,'radius2'=>20},
      'austin' => {'lat'=>30.26715,'lon'=>-97.74306,'groupon'=>'austin','zip'=>78701,'radius'=>70,'radius2'=>20},
      'boston' => {'lat'=>42.35843,'lon'=>-71.05977,'groupon'=>'boston','zip'=>'02111','radius'=>30,'radius2'=>20},
      'denver' => {'lat'=>39.73915,'lon'=>-104.98470,'groupon'=>'denver','zip'=>80203,'radius'=>70,'radius2'=>40},
      'dallas' => {'lat'=>32.80295,'lon'=>-96.76992,'groupon'=>'dallas','zip'=>75214,'radius'=>100,'radius2'=>50,'zoom'=>12},
      'houston' => {'lat'=>29.76019,'lon'=>-95.36939,'groupon'=>'houston','zip'=>77002,'radius'=>100,'radius2'=>20,'zoom'=>12},
      'baltimore' => {'lat'=>39.29038,'lon'=>-76.61219,'groupon'=>'baltimore','zip'=>21202,'radius'=>20,'radius2'=>20},
      'charlotte' => {'lat'=>35.22709,'lon'=>-80.84313,'groupon'=>'charlotte','zip'=>28202,'radius'=>30,'radius2'=>20},
      'phoenix' => {'lat'=>33.44838,'lon'=>-112.07404,'groupon'=>'phoenix','zip'=>85004,'radius'=>100,'radius2'=>50},
      'jacksonville' => {'lat'=>30.33218,'lon'=>-81.65565,'groupon'=>'jacksonville','zip'=>'32202','radius'=>60,'radius2'=>30},
      'indianapolis' => {'lat'=>39.76838,'lon'=>-86.15804,'groupon'=>'indianapolis','zip'=>'46204','radius'=>50,'radius2'=>25},
      'columbus' => {'lat'=>39.96118,'lon'=>-82.99879,'groupon'=>'columbus','zip'=>'43215','radius'=>50,'radius2'=>25},
      'sacramento' => {'lat'=>38.58157,'lon'=>-121.49440,'groupon'=>'sacramento','zip'=>'95814','radius'=>70,'radius2'=>30},
      'detroit' => {'lat'=>42.32784,'lon'=>-83.04909,'groupon'=>'detroit','zip'=>'48226','radius'=>60,'radius2'=>30},
      'memphis' => {'lat'=>35.14953,'lon'=>-90.04898,'groupon'=>'memphis','zip'=>'38103','radius'=>60,'radius2'=>30},
      'milwaukee' => {'lat'=>43.03890,'lon'=>-87.90647,'groupon'=>'milwaukee','zip'=>'53202','radius'=>50,'radius2'=>25},
      'minneapolis' => {'lat'=>44.97997,'lon'=>-93.26384,'groupon'=>'minneapolis','zip'=>'55403','radius'=>50,'radius2'=>25},
      'lv' => {'lat'=>36.11465,'lon'=>-115.17282,'groupon'=>'las-vegas','zip'=>'89109','radius'=>50,'radius2'=>25}

    }
  end

  def plancast
    query = 'http://api.plancast.com/02/plans/search.json?q=party'
    pc_request = URI.parse(query)
    pc_array = Net::HTTP.get_response(pc_request).body
    plancast = JSON.parse(pc_array)
  end

  def socializr
    key = '981AF714AEC11EEB664EE53F11143B98'
    query = 'http://api.plancast.com/02/plans/search.json?q=party'
    s_request = URI.parse(query)
    s_array = Net::HTTP.get_response(s_request).body
    socializr = s_array.to_xml
  end

  def ticketfly(city,day,amount,page=false)
    string = "http://www.ticketfly.com/api/events/list.json?orgId=1234&fromDate=2008-11-01&thruDate=2008-11-30&pageNum=5&maxResults=10"
    t_request = URI.parse(string)
    t_array = Net::HTTP.get_response(t_request).body
    @active = JSON.parse(t_array)
  end

  def allforgood

  end

end
