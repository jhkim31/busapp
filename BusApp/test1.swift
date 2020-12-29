import MapKit
import SwiftUI

struct test1: View {
	
	@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

	var body: some View {
		VStack{
			Text("center of Map")
			HStack{
				Text(String(region.center.latitude))
				Text(String(region.center.longitude))
			}
			Text("current Position")
//			HStack{
//				Text(String(userLatitude))
//				Text(String(userLongitude))
//			}
			Map(coordinateRegion: $region)
			
			
			
		}
	}
}

struct test1_Previews: PreviewProvider {
    static var previews: some View {
        test1()
    }
}
