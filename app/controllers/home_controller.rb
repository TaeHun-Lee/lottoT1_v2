require ('open-uri')
require ('json')


class HomeController < ApplicationController
    def picklotto_auto
        $lotto_data = Lotto.new
        $lotto_data.lotton = params[:l_number]
        $lotto_data.save
        # input에서 입력받은 회차번호를 모델을 거쳐 $pick_lottonum 전역변수에 할당. 이렇게 하는 이유는 인스턴수 변수로 선언하니 입력페이지를 한번 거쳐가는 수동페이지 액션에서 값을 받지못함.
        
        @pick = params[:choice]
        if @pick == "자동"
        $lotto_data.choice = "자동"
        $lotto_data.save
        
        @url = 'http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo='
        @real_lotto = JSON.parse(open(@url + $lotto_data.lotton).read)
        # input에서 입력받은 회차수를 파라미터로 하여 로또 api 주소 끝에 붙임(주소 끝에 미입력시 최신회차로 자동파싱이 되지 않아 이렇게 처리)
        
        @real_lotto_num = Array.new
        @real_lotto.each do |key, value|
            @real_lotto_num.push(value) if key.include? 'drwtNo'
        end
        @real_lotto_num.sort!
        @bonus_num = @real_lotto["bnusNo"]
        # 로또 api 내에서 실제 당첨번호는 drwtNo를 key값으로 가진 value이기 때문에 이를 새로운 배열로 push 하고 sort!, 보너스 넘버는 따로 뽑음
        
        $lotto_data.lttoarr = @real_lotto_num
        $lotto_data.save
        
        $lotto_data.lbonum = @bonus_num
        $lotto_data.save
        
                
        @arr = (1..45).to_a
        @rand_arr = @arr.sample(6).sort
        
        $lotto_data.lttorandarr = @rand_arr
        $lotto_data.save
        
        @get_arr = Array.new
        @rand_arr.each do |number|
            if (@real_lotto_num.include?(number))
                @get_arr.push(number)
            end
        end
        # 랜덤으로 추첨된 번호와 실제 당첨 번호가 일치할 시 get_arr라는 일치배열에 push
        
        $lotto_data.lttogetarr = @get_arr
        $lotto_data.save
        
        
        elsif @pick == "수동"
        $lotto_data.choice = "수동"
        $lotto_data.save
        redirect_to '/manual'
        
        
        else redirect_to '/'
        end
    end
    
    
    def picklotto_manual
    end
    
    
    def picklotto_manual_result
        @url = 'http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo='
        @real_lotto = JSON.parse(open(@url + $lotto_data.lotton).read)
        # 로또 api 주소 끝에 붙임. 아까 할당했던 전역변수를 여기서 불러옴. save하지 않아서 db에 저장되지 않는 것 확인함.
        
        @real_lotto_num = Array.new
        @real_lotto.each do |key, value|
            @real_lotto_num.push(value) if key.include? 'drwtNo'
        end
        @real_lotto_num.sort!
        @bonus_num = @real_lotto["bnusNo"]
        # auto와 마찬가지로 로또 api 내에서 실제 당첨번호는 drwtNo를 key값으로 가진 value이기 때문에 이를 새로운 배열로 push 하고 sort!, 보너스 넘버는 따로 뽑음
        
        $lotto_data.lttoarr = @real_lotto_num
        $lotto_data.save
        
        $lotto_data.lbonum = @bonus_num
        $lotto_data.save

      @num1 = params[:num1].to_i
      @num2 = params[:num2].to_i
      @num3 = params[:num3].to_i
      @num4 = params[:num4].to_i
      @num5 = params[:num5].to_i
      @num6 = params[:num6].to_i
      # integer으로 만들어주지 않으니 "" 처리로 string값으로 받았기 때문에 to_i 처리
      
      @manual_arr = [@num1,@num2,@num3,@num4,@num5,@num6].sort
      # 수동으로 입력된 번호들을 배열화.
      
      $lotto_data.lttorandarr = @manual_arr
      $lotto_data.save
      
      if @num1 == @num2 || @num1 == @num3 || @num1 == @num4 || @num1 == @num5 || @num1 == @num6 || @num2 == @num3 || @num2 == @num4 || @num2 == @num5 || @num2 == @num6 ||
        @num3 == @num4 || @num3 == @num5 || @num3 == @num6 || @num4 == @num5 || @num4 == @num6 || @num5 == @num6
        redirect_to '/manual'
      end
      # 수동으로 뽑은 번호들이 서로 중복될 경우 다시 뽑도록 메뉴얼로 보내기
      # 원래는 중복 번호를 입력할 경우 JS 이용하여 alert 팝업시켜주고 싶었는데 무슨 이유에선지 제대로 작동하지 않아서 일단 원시적으로 처리함
      
      @get_manual_arr = Array.new
      
      @manual_arr.each do |number|
        if (@real_lotto_num.include?(number))
          @get_manual_arr.push(number)
        end
      end
      
      $lotto_data.lttogetarr = @get_manual_arr
      $lotto_data.save
      
    end
    
    def input
      $lotto_datas = Lotto.all.reverse
    end
end