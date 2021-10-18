<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="myModal" class="modal2" style="margin-left:0px;">
	<div class="modal2-content">
		<span class="close">&times; </span>
		 <div id="filters">
			<h1>FILTER</h1>
			<h2>정렬</h2>
			<div id="sorting">
				<div><input type="radio" name="orderby" value="datetime_ASC" checked>시간순</div>
				<div><input type="radio" name="orderby" value="datetime_DESC">역시간순</div>
				<div><input type="radio" name="orderby" value="price_ASC">낮은가격순</div>
				<div><input type="radio" name="orderby" value="price_DESC">높은가격순</div>
			</div> <!-- 정렬 -->
			<hr/>
			<h2>시간대</h2>
			<div id="timeRange">
				<div><input  type="checkbox" name="before_six_am" value="true">오전 00:00 ~ 오전 6:00 	(<span id="count_before_six_am"></span>)</div>
				<div><input type="checkbox" name="six_to_noon" value="true">오전 6:00 ~ 오후 12:00 	(<span id="count_six_to_noon"></span>)</div>
				<div><input type="checkbox" name="noon_to_six" value="true">오후 12:00 ~ 오후 6:00	 (<span id="count_noon_to_six"></span>)</div>
				<div><input type="checkbox" name="after_six" value="true">오후 6:00 ~ 오후 11:59 	(<span id="count_after_six"></span>)</div>
			</div> <!-- 시간대 -->
			<hr/>
			<h2>운전자 정보</h2>
			차종 : </br>
			<div id="carModel">
				<div><input type="checkbox" name="carModel1" value="true">소형 (<span id="count_carModel1"></span>)</div>
				<div><input type="checkbox" name="carModel2" value="true">중형 (<span id="count_carModel2"></span>) </div>
				<div><input type="checkbox" name="carModel3" value="true">대형 (<span id="count_carModel3"></span>)</div>
			</div> <!--  카모델 -->
	
			<br/> 연령대 : <br/>
			<div id="ageGroup">	
				<div><input type="checkbox" name="twenties" value="true">20대 (<span id="count_twenties"></span>)</div>
				<div><input type="checkbox" name="thirties" value="true">30대 (<span id="count_thirties"></span>)</div>
				<div><input type="checkbox" name="forties" value="true">40대 (<span id="count_forties"></span>) </div>
				<div><input type="checkbox" name="fifties" value="true">50대 (<span id="count_fifties"></span>)</div>
				<div><input type="checkbox" name="sixties" value="true">60대 (<span id="count_sixties"></span>)</div>
				<div><input type="checkbox" name="seventies" value="true">70대 (<span id="count_seventies"></span>)</div>
			</div><!-- 연령대 -->
			
			<br/> 성별:<br/>
			<div id="gender">
				<div><input type="checkbox" name="female" value="true">여성 (<span id="count_female"></span>)</div>
				<div><input type="checkbox" name="male" value="true">남성 (<span id="count_male"></span>)</div>
			</div> <!-- 성별 -->
	
			<br/> 최대 탑승 수용 인원 : <br/>
			<div id="maxPassanger">
				<div><input type="checkbox" name="seat1" value="true"> 1명 (<span id="count_seat1"></span>) </div>
				<div><input type="checkbox" name="seat2" value="true"> 2명 (<span id="count_seat2"></span>) </div>
				<div><input type="checkbox" name="seat3" value="true"> 3명 (<span id="count_seat3"></span>)</div>
				<div><input type="checkbox" name="seat4" value="true"> 4명 (<span id="count_seat4"></span>)</div>
				<div><input type="checkbox" name="seat5" value="true"> 5인 이상 (<span id="count_seat5"></span>)</div>
		</div> <!-- 최대탑승수용인원 --> <br/>
			
			<input id="filterFormSubmit" type="submit" class="search-btn" value="검색" /> 
		</div>
	</div>
</div>