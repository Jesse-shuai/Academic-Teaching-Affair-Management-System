package com.niit.controller.admin;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.niit.bean.Administrator;
import com.niit.bean.PageBean;
import com.niit.service.AdministratorService;
import com.niit.util.ResponseUtil;

@Controller
@RequestMapping("/admin")
public class AdministratorController {
    
    @Resource
    private AdministratorService administratorService;
    
    @RequestMapping("/admin_list")
    public String adminList(ModelMap resultMap) {
        List<Administrator> list = administratorService.selectAdministratorList();
        resultMap.addAttribute("list", list);
        return "admin/admin_list";
    }
    
    @RequestMapping("/select_admin_list")
    public String selectAdminList(
            @RequestParam(value = "page", required = false) String page,
            @RequestParam(value = "limit", required = false) String limit,
            HttpServletResponse response) throws Exception {
        
        //定义分页
        PageBean<Administrator> pageBean = new PageBean<Administrator>(
            Integer.parseInt(page),
            Integer.parseInt(limit));
        //拿到分页结果已经记录总数的page
        pageBean = administratorService.selectAdministratorListByPage(pageBean);

        //使用阿里巴巴的fastJson创建JSONObject
        JSONObject result = new JSONObject();
        //通过fastJson序列化list为jsonArray
        String jsonArray = JSON.toJSONString(pageBean.getResult());
        JSONArray array = JSONArray.parseArray(jsonArray);
        //将序列化结果放入json对象中
        result.put("data", array);
        result.put("count", pageBean.getTotal());
        result.put("code", 0);

        //使用自定义工具类向response中写入数据
        ResponseUtil.write(response, result);
        return null;
    }
    
    @RequestMapping("/update_admin")
    public String updateAdmin(Administrator administrator) {
        Integer i = administratorService.updateAdministrator(administrator);
        
        return "admin/admin_list";
    }

    @RequestMapping(value="/delete_admin")
    public String deleteAdmin(String user, HttpServletResponse response) throws Exception {
        Integer i = administratorService.deleteAdministratorByUser(user);
        
        //使用阿里巴巴的fastJson创建JSONObject
        JSONObject result = new JSONObject();
        //将序列化结果放入json对象中
        result.put("success", true);
        
        //使用自定义工具类向response中写入数据
        ResponseUtil.write(response, result);
        return null;
    }
    
    @RequestMapping("/insert_admin")
    public String insertAdmin(Administrator administrator, HttpServletResponse response) throws Exception {
        Integer i = administratorService.insertAdministrator(administrator);
        
        return "admin/admin_list";
    }

}
