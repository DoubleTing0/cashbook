package util;

import java.util.*;

public class Page {

	// beginRow
	public int getBeginRow(int currentPage, int rowPerPage) {
		
		int beginRow = (currentPage - 1) * rowPerPage;
				
		return beginRow;
	}
	
	// previousPage
	public int getPreviousPage(int currentPage, int pageLength) {
		
		int previousPage = (((currentPage - 1) / pageLength) * pageLength) - (pageLength - 1);
		
		return previousPage;
		
	}
	
	// nextPage
	public int getNextPage(int currentPage, int pageLength) {
		
		int nextPage = (((currentPage - 1) / pageLength) * pageLength) + (pageLength + 1);
		
		return nextPage;
		
	}
	
	// lastpage
	public int getLastPage(int count, int rowPerPage) {
		
		int lastPage = count /rowPerPage;
		if((count % rowPerPage) != 0) {
			lastPage += 1;
		}
		
		return lastPage;
	}
	
	// pageList
	public ArrayList<Integer> getPageList(int currentPage, int pageLength) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		
		for(int x=1; x<=pageLength; x+=1) {
			int page = (((currentPage -1) / pageLength) * pageLength) + x;
			list.add(page);
		}
		
		return list;
	}
	
	
}
