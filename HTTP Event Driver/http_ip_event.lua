<devicedata>
  <copyright>Copyright 2013 BrightSky.  All rights reserved.</copyright>
  <manufacturer>BrightSky</manufacturer>
  <creator>Seth_J</creator>
  <created>4/15/2013 9:00:00 AM</created>
  <modified>4/15/2013 9:00:00 AM</modified>
  <name>HTTP Event Driver</name>
  <model>HTTP Event Driver</model>
  <small />
  <large />
  <control>lua_gen</control>
  <proxy>http_ip_event</proxy>
  <driver>DriverWorks</driver>
  <version>010</version>
	<config>
	    <script>
<![CDATA[



--------------- Driver Functions --------------

function processMessage ( strData , nHandle)

	local _,_, g = string.find(strData, "GET /(%w*) ")
	
	fireEvent(g)
	--close socket nHandle
	C4:ServerSend(nHandle, "OK")
	C4:ServerCloseClient(nHandle)
end


function fireEvent( eventId )
	C4:FireEvent( 'Event '.. eventId )
end



------------- Called By Director ---------------

function OnServerConnectionStatusChanged( nHandle, nPort, strStatus )
	if (strStatus == "ONLINE") then
		print("Server Connection Established: " .. nHandle .. " : " .. strStatus)
	else
		print("Server Connection Disconnected: " .. nHandle .. " : " .. strStatus)
	end
end

function OnServerDataIn( nHandle, strData )
	processMessage( strData, nHandle )
end


function OnDriverDestroyed()
	-- Kill any running servers
	KillServers()
	--Clean timers
	gInitTimer = nil
end

function OnPropertyChanged( strProperty )

	if (strProperty == 'Port') then
		-- Kill SS
		KillServers()
		-- Start new SS on new Port
		gInitTimer = C4:AddTimer(5, "SECONDS", false);
	end

end


function OnTimerExpired( idTimer )

	if (idTimer == gInitTimer) then
		print("Init Timer expired. Starting ServerSockets.")
		StartServer(tonumber(Properties['Port'])) -- startup server on 4041
	
	elseif (idTimer == g_DebugTimer) then
    	dbg('Turning Debug Mode back to Off (timer expired)')
    	C4:UpdateProperty('Debug Mode', 'Off')
    	gDebugPrint = false
    	gDebugLog = false
    	gDebugTimer = C4:KillTimer(gDebugTimer)
    else
    	dbg('Killed Stray Timer: ' .. idTimer)
    	C4:KillTimer(idTimer)
  	end
	
end





---------------- Utility -----------------

function dbg(strDebugText, strDebugLevel)
  	if (strDebugLevel == nil) then strDebugLevel = "std" end
  	if (gDebugLevel == strDebugLevel) then
    	if (gDebugPrint) then print(os.date("[%x %X] "), strDebugText) end 
    	if (gDebugLog) then C4:ErrorLog(strDebugText) end 
  	end
end



function StartServer( nPort )

	C4:CreateServer(nPort)
	print("ServerSocket Created on Port " .. nPort)

end

function KillServers()

	C4:DestroyServer()
	print("All ServerScokets Stopped.")
	
end



function startDebugTimer()
  
  if (gDebugTimer) then
    gDebugTimer = C4:KillTimer(gDebugTimer);
  end
  gDebugTimer = C4:AddTimer(10, 'MINUTES');

end



-------- INIT -------

gInitTimer = C4:AddTimer(5, "SECONDS")


gDebugLevel = "std";
gDebugPrint = false;
gDebugLog = false;
gDebugTimer = 0;
gConnectionStatus = false;
gPortNumber = 2555

gEventTable = {}

for i=1,10 do
	C4:AddVariable("EVENT_" .. i .. "_ACTIVE", "0", "BOOL");
end


------- END INIT --------
]]>		
		</script>
	    <documentation>


		
		</documentation>
	    <properties>
			<property>
		        <name>BrightSky</name>
		        <type>STRING</type>
				<default>HTTP Event Driver v1.0</default>
		        <readonly>true</readonly>
			</property>
			<property>
		        <name>Status</name>
		        <type>STRING</type>
				<default></default>
		        <readonly>true</readonly>
			</property>

			<property>
		        <name>Port</name>
		        <type>STRING</type>
				<default>8085</default>
		        <readonly>false</readonly>
			</property>
			<property>
		        <name>Debug Mode</name>
		        <type>LIST</type>
		        <items>
					  <item>Off</item>
			          <item>Print</item>
		        </items>
		        <default>Off</default>
		        <readonly>false</readonly>
			</property>

		
	    </properties>
	<actions />
    <commands/>
	</config>
	<states />
  	<connections />
	<capabilities />
	<commands />
	<conditionals />
	<events>
<event>
    <id>1</id>
    <name>Event 1 </name>
    <description>Event 1 from NAME... do the following:</description>
  </event>
<event>
    <id>2</id>
    <name>Event 2 </name>
    <description>Event 2 from NAME... do the following:</description>
  </event>
<event>
    <id>3</id>
    <name>Event 3 </name>
    <description>Event 3 from NAME... do the following:</description>
  </event>
<event>
    <id>4</id>
    <name>Event 4 </name>
    <description>Event 4 from NAME... do the following:</description>
  </event>
<event>
    <id>5</id>
    <name>Event 5 </name>
    <description>Event 5 from NAME... do the following:</description>
  </event>
<event>
    <id>6</id>
    <name>Event 6 </name>
    <description>Event 6 from NAME... do the following:</description>
  </event>
<event>
    <id>7</id>
    <name>Event 7 </name>
    <description>Event 7 from NAME... do the following:</description>
  </event>
<event>
    <id>8</id>
    <name>Event 8 </name>
    <description>Event 8 from NAME... do the following:</description>
  </event>
<event>
    <id>9</id>
    <name>Event 9 </name>
    <description>Event 9 from NAME... do the following:</description>
  </event>
<event>
    <id>10</id>
    <name>Event 10 </name>
    <description>Event 10 from NAME... do the following:</description>
  </event>
<event>
    <id>11</id>
    <name>Event 11 </name>
    <description>Event 11 from NAME... do the following:</description>
  </event>
<event>
    <id>12</id>
    <name>Event 12 </name>
    <description>Event 12 from NAME... do the following:</description>
  </event>
<event>
    <id>13</id>
    <name>Event 13 </name>
    <description>Event 13 from NAME... do the following:</description>
  </event>
<event>
    <id>14</id>
    <name>Event 14 </name>
    <description>Event 14 from NAME... do the following:</description>
  </event>
<event>
    <id>15</id>
    <name>Event 15 </name>
    <description>Event 15 from NAME... do the following:</description>
  </event>
<event>
    <id>16</id>
    <name>Event 16 </name>
    <description>Event 16 from NAME... do the following:</description>
  </event>
<event>
    <id>17</id>
    <name>Event 17 </name>
    <description>Event 17 from NAME... do the following:</description>
  </event>
<event>
    <id>18</id>
    <name>Event 18 </name>
    <description>Event 18 from NAME... do the following:</description>
  </event>
<event>
    <id>19</id>
    <name>Event 19 </name>
    <description>Event 19 from NAME... do the following:</description>
  </event>
<event>
    <id>20</id>
    <name>Event 20 </name>
    <description>Event 20 from NAME... do the following:</description>
  </event>
<event>
    <id>21</id>
    <name>Event 21 </name>
    <description>Event 21 from NAME... do the following:</description>
  </event>
<event>
    <id>22</id>
    <name>Event 22 </name>
    <description>Event 22 from NAME... do the following:</description>
  </event>
<event>
    <id>23</id>
    <name>Event 23 </name>
    <description>Event 23 from NAME... do the following:</description>
  </event>
<event>
    <id>24</id>
    <name>Event 24 </name>
    <description>Event 24 from NAME... do the following:</description>
  </event>
<event>
    <id>25</id>
    <name>Event 25 </name>
    <description>Event 25 from NAME... do the following:</description>
  </event>
<event>
    <id>26</id>
    <name>Event 26 </name>
    <description>Event 26 from NAME... do the following:</description>
  </event>
<event>
    <id>27</id>
    <name>Event 27 </name>
    <description>Event 27 from NAME... do the following:</description>
  </event>
<event>
    <id>28</id>
    <name>Event 28 </name>
    <description>Event 28 from NAME... do the following:</description>
  </event>
<event>
    <id>29</id>
    <name>Event 29 </name>
    <description>Event 29 from NAME... do the following:</description>
  </event>
<event>
    <id>31</id>
    <name>Event 31 </name>
    <description>Event 31 from NAME... do the following:</description>
  </event>
<event>
    <id>30</id>
    <name>Event 30 </name>
    <description>Event 30 from NAME... do the following:</description>
  </event>
<event>
    <id>32</id>
    <name>Event 32 </name>
    <description>Event 32 from NAME... do the following:</description>
  </event>
<event>
    <id>33</id>
    <name>Event 33 </name>
    <description>Event 33 from NAME... do the following:</description>
  </event>
<event>
    <id>34</id>
    <name>Event 34 </name>
    <description>Event 34 from NAME... do the following:</description>
  </event>
<event>
    <id>35</id>
    <name>Event 35 </name>
    <description>Event 35 from NAME... do the following:</description>
  </event>
<event>
    <id>36</id>
    <name>Event 36 </name>
    <description>Event 36 from NAME... do the following:</description>
  </event>
<event>
    <id>37</id>
    <name>Event 37 </name>
    <description>Event 37 from NAME... do the following:</description>
  </event>
<event>
    <id>38</id>
    <name>Event 38 </name>
    <description>Event 38 from NAME... do the following:</description>
  </event>
<event>
    <id>40</id>
    <name>Event 40 </name>
    <description>Event 40 from NAME... do the following:</description>
  </event>
<event>
    <id>41</id>
    <name>Event 41 </name>
    <description>Event 41 from NAME... do the following:</description>
  </event>
<event>
    <id>42</id>
    <name>Event 42 </name>
    <description>Event 42 from NAME... do the following:</description>
  </event>
<event>
    <id>43</id>
    <name>Event 43 </name>
    <description>Event 43 from NAME... do the following:</description>
  </event>
<event>
    <id>44</id>
    <name>Event 44 </name>
    <description>Event 44 from NAME... do the following:</description>
  </event>
<event>
    <id>45</id>
    <name>Event 45 </name>
    <description>Event 45 from NAME... do the following:</description>
  </event>
<event>
    <id>46</id>
    <name>Event 46 </name>
    <description>Event 46 from NAME... do the following:</description>
  </event>
<event>
    <id>47</id>
    <name>Event 47 </name>
    <description>Event 47 from NAME... do the following:</description>
  </event>
<event>
    <id>48</id>
    <name>Event 48 </name>
    <description>Event 48 from NAME... do the following:</description>
  </event>
<event>
    <id>49</id>
    <name>Event 49 </name>
    <description>Event 49 from NAME... do the following:</description>
  </event>
<event>
    <id>50</id>
    <name>Event 50 </name>
    <description>Event 50 from NAME... do the following:</description>
  </event>
<event>
    <id>51</id>
    <name>Event 51 </name>
    <description>Event 51 from NAME... do the following:</description>
  </event>
<event>
    <id>52</id>
    <name>Event 52 </name>
    <description>Event 52 from NAME... do the following:</description>
  </event>
<event>
    <id>39</id>
    <name>Event 39 </name>
    <description>Event 39 from NAME... do the following:</description>
  </event>
<event>
    <id>53</id>
    <name>Event 53 </name>
    <description>Event 53 from NAME... do the following:</description>
  </event>
<event>
    <id>54</id>
    <name>Event 54 </name>
    <description>Event 54 from NAME... do the following:</description>
  </event>
<event>
    <id>55</id>
    <name>Event 55 </name>
    <description>Event 55 from NAME... do the following:</description>
  </event>
<event>
    <id>56</id>
    <name>Event 56 </name>
    <description>Event 56 from NAME... do the following:</description>
  </event>
<event>
    <id>57</id>
    <name>Event 57 </name>
    <description>Event 57 from NAME... do the following:</description>
  </event>
<event>
    <id>58</id>
    <name>Event 58 </name>
    <description>Event 58 from NAME... do the following:</description>
  </event>
<event>
    <id>59</id>
    <name>Event 59 </name>
    <description>Event 59 from NAME... do the following:</description>
  </event>
<event>
    <id>60</id>
    <name>Event 60 </name>
    <description>Event 60 from NAME... do the following:</description>
  </event>
<event>
    <id>61</id>
    <name>Event 61 </name>
    <description>Event 61 from NAME... do the following:</description>
  </event>
<event>
    <id>62</id>
    <name>Event 62 </name>
    <description>Event 62 from NAME... do the following:</description>
  </event>
<event>
    <id>63</id>
    <name>Event 63 </name>
    <description>Event 63 from NAME... do the following:</description>
  </event>
<event>
    <id>64</id>
    <name>Event 64 </name>
    <description>Event 64 from NAME... do the following:</description>
  </event>
<event>
    <id>65</id>
    <name>Event 65 </name>
    <description>Event 65 from NAME... do the following:</description>
  </event>
<event>
    <id>66</id>
    <name>Event 66 </name>
    <description>Event 66 from NAME... do the following:</description>
  </event>
<event>
    <id>67</id>
    <name>Event 67 </name>
    <description>Event 67 from NAME... do the following:</description>
  </event>
<event>
    <id>68</id>
    <name>Event 68 </name>
    <description>Event 68 from NAME... do the following:</description>
  </event>
<event>
    <id>69</id>
    <name>Event 69 </name>
    <description>Event 69 from NAME... do the following:</description>
  </event>
<event>
    <id>70</id>
    <name>Event 70 </name>
    <description>Event 70 from NAME... do the following:</description>
  </event>
<event>
    <id>71</id>
    <name>Event 71 </name>
    <description>Event 71 from NAME... do the following:</description>
  </event>
<event>
    <id>72</id>
    <name>Event 72 </name>
    <description>Event 72 from NAME... do the following:</description>
  </event>
<event>
    <id>73</id>
    <name>Event 73 </name>
    <description>Event 73 from NAME... do the following:</description>
  </event>
<event>
    <id>74</id>
    <name>Event 74 </name>
    <description>Event 74 from NAME... do the following:</description>
  </event>
<event>
    <id>75</id>
    <name>Event 75 </name>
    <description>Event 75 from NAME... do the following:</description>
  </event>
<event>
    <id>76</id>
    <name>Event 76 </name>
    <description>Event 76 from NAME... do the following:</description>
  </event>
<event>
    <id>77</id>
    <name>Event 77 </name>
    <description>Event 77 from NAME... do the following:</description>
  </event>
<event>
    <id>78</id>
    <name>Event 78 </name>
    <description>Event 78 from NAME... do the following:</description>
  </event>
<event>
    <id>79</id>
    <name>Event 79 </name>
    <description>Event 79 from NAME... do the following:</description>
  </event>
<event>
    <id>80</id>
    <name>Event 80 </name>
    <description>Event 80 from NAME... do the following:</description>
  </event>
<event>
    <id>81</id>
    <name>Event 81 </name>
    <description>Event 81 from NAME... do the following:</description>
  </event>
<event>
    <id>82</id>
    <name>Event 82 </name>
    <description>Event 82 from NAME... do the following:</description>
  </event>
<event>
    <id>83</id>
    <name>Event 83 </name>
    <description>Event 83 from NAME... do the following:</description>
  </event>
<event>
    <id>84</id>
    <name>Event 84 </name>
    <description>Event 84 from NAME... do the following:</description>
  </event>
<event>
    <id>85</id>
    <name>Event 85 </name>
    <description>Event 85 from NAME... do the following:</description>
  </event>
<event>
    <id>86</id>
    <name>Event 86 </name>
    <description>Event 86 from NAME... do the following:</description>
  </event>
<event>
    <id>87</id>
    <name>Event 87 </name>
    <description>Event 87 from NAME... do the following:</description>
  </event>
<event>
    <id>88</id>
    <name>Event 88 </name>
    <description>Event 88 from NAME... do the following:</description>
  </event>
<event>
    <id>89</id>
    <name>Event 89 </name>
    <description>Event 89 from NAME... do the following:</description>
  </event>
<event>
    <id>90</id>
    <name>Event 90 </name>
    <description>Event 90 from NAME... do the following:</description>
  </event>
<event>
    <id>91</id>
    <name>Event 91 </name>
    <description>Event 91 from NAME... do the following:</description>
  </event>
<event>
    <id>92</id>
    <name>Event 92 </name>
    <description>Event 92 from NAME... do the following:</description>
  </event>
<event>
    <id>93</id>
    <name>Event 93 </name>
    <description>Event 93 from NAME... do the following:</description>
  </event>
<event>
    <id>94</id>
    <name>Event 94 </name>
    <description>Event 94 from NAME... do the following:</description>
  </event>
<event>
    <id>95</id>
    <name>Event 95 </name>
    <description>Event 95 from NAME... do the following:</description>
  </event>
<event>
    <id>96</id>
    <name>Event 96 </name>
    <description>Event 96 from NAME... do the following:</description>
  </event>
<event>
    <id>97</id>
    <name>Event 97 </name>
    <description>Event 97 from NAME... do the following:</description>
  </event>
<event>
    <id>98</id>
    <name>Event 98 </name>
    <description>Event 98 from NAME... do the following:</description>
  </event>
<event>
    <id>99</id>
    <name>Event 99 </name>
    <description>Event 99 from NAME... do the following:</description>
  </event>
<event>
    <id>100</id>
    <name>Event 100 </name>
    <description>Event 100 from NAME... do the following:</description>
  </event>
</events>

</devicedata>